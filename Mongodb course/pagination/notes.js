// Import MongoDB ODM (Object Document Mapper) library
import mongoose from 'mongoose';

/**
 * Main function demonstrating pagination in MongoDB
 */
async function run() {
  // ==================== DATABASE CONNECTION ====================
  // Connect to MongoDB database named 'indexDemo'
  await mongoose.connect('mongodb://localhost:27017/indexDemo');
  console.log('✅ Connected to MongoDB database: indexDemo');

  // ==================== SCHEMA & MODEL DEFINITION ====================
  /**
   * Create a Mongoose model named 'Address'
   * Schema options:
   * - { strict: false }: Allows documents with any structure
   *   → MongoDB won't reject documents with extra fields
   *   → Useful for flexible schemas during development
   */
  const Address = mongoose.model(
    'Address', // Model name (collection will be 'addresses')
    new mongoose.Schema({}, { strict: false }), // Schema definition
  );

  // ==================== PAGINATION PARAMETERS ====================
  /**
   * Page number user wants to view
   * Humans: Page numbers start from 1
   * Databases: Indexes start from 0
   */
  const page = 2; // User wants to see page 2

  /**
   * Number of documents per page
   * Balance between:
   * - Too small: Too many page requests
   * - Too large: Slow loading, poor UX
   * Common values: 10, 20, 50, 100
   */
  const limit = 5; // Show 5 documents per page

  // ==================== PAGINATION CALCULATION ====================
  /**
   * Calculate how many documents to SKIP
   * Formula: skip = (page - 1) * limit
   *
   * Example with page=2, limit=5:
   * skip = (2 - 1) * 5 = 5
   *
   * What this means:
   * Page 1: Show documents 0-4 (skip 0)
   * Page 2: Show documents 5-9 (skip 5)
   * Page 3: Show documents 10-14 (skip 10)
   */
  const skip = (page - 1) * limit;

  // ==================== VISUAL EXAMPLE ====================
  console.log('\n📊 PAGINATION EXAMPLE');
  console.log('=====================');
  console.log(`Page requested: ${page}`);
  console.log(`Items per page: ${limit}`);
  console.log(`Skip calculation: (${page} - 1) × ${limit} = ${skip}`);
  console.log('\n📄 Document Range Visualization:');
  console.log('Page 1 → Documents: 1 to 5   (skip: 0)');
  console.log('Page 2 → Documents: 6 to 10  (skip: 5) ← You are here');
  console.log('Page 3 → Documents: 11 to 15 (skip: 10)');

  // ==================== DATABASE QUERY ====================
  console.log('\n🔍 Executing paginated query...');
  console.log(`Query: Find all addresses, skip ${skip}, limit ${limit}`);

  try {
    /**
     * Execute paginated query:
     * 1. find({}) → Get all documents
     * 2. skip(skip) → Skip initial documents
     * 3. limit(limit) → Limit results to page size
     *
     * Note: For large collections, consider using cursor-based pagination instead
     */
    const result = await Address.find({})
      .skip(skip) // Skip documents from previous pages
      .limit(limit); // Limit to page size

    // ==================== DISPLAY RESULTS ====================
    console.log('\n✅ Query Results:');
    console.log(`Total documents retrieved: ${result.length}`);
    console.log('Documents:');

    if (result.length === 0) {
      console.log('No documents found for this page.');
    } else {
      result.forEach((doc, index) => {
        console.log(`  ${index + 1}. ${JSON.stringify(doc)}`);
      });
    }

    // ==================== ADDITIONAL METADATA (Optional) ====================
    /**
     * In real applications, you'll want to return:
     * 1. The data for current page
     * 2. Total document count (for calculating total pages)
     * 3. Current page number
     * 4. Items per page
     */
    const totalDocuments = await Address.countDocuments({});
    const totalPages = Math.ceil(totalDocuments / limit);

    console.log('\n📈 Pagination Metadata:');
    console.log(`Total documents in collection: ${totalDocuments}`);
    console.log(`Total pages available: ${totalPages}`);
    console.log(`Current page: ${page} of ${totalPages}`);
    console.log(
      `Showing documents: ${skip + 1} to ${Math.min(
        skip + limit,
        totalDocuments,
      )}`,
    );
  } catch (error) {
    console.error('\n❌ Error executing query:', error.message);
  }

  // ==================== CLEANUP ====================
  // Disconnect from MongoDB
  await mongoose.disconnect();
  console.log('\n🔌 Disconnected from MongoDB');
}

// ==================== ALTERNATIVE IMPLEMENTATIONS ====================

/**
 * Enhanced pagination function with better structure
 * @param {number} page - Page number (starting from 1)
 * @param {number} limit - Items per page
 * @returns {Object} Paginated results with metadata
 */
async function getPaginatedResults(page = 1, limit = 10) {
  // Validate inputs
  if (page < 1) page = 1;
  if (limit < 1) limit = 10;
  if (limit > 100) limit = 100; // Prevent excessive loading

  const skip = (page - 1) * limit;

  // Parallel execution for better performance
  const [data, total] = await Promise.all([
    Address.find({}).skip(skip).limit(limit).lean(), // Returns plain JavaScript objects (faster)
    Address.countDocuments({}),
  ]);

  // Calculate pagination metadata
  const totalPages = Math.ceil(total / limit);
  const hasNextPage = page < totalPages;
  const hasPrevPage = page > 1;

  return {
    data, // Current page data
    pagination: {
      currentPage: page,
      totalPages,
      totalItems: total,
      itemsPerPage: limit,
      hasNextPage,
      hasPrevPage,
      nextPage: hasNextPage ? page + 1 : null,
      prevPage: hasPrevPage ? page - 1 : null,
      showingStart: skip + 1,
      showingEnd: Math.min(skip + limit, total),
    },
  };
}

/**
 * Real-world API endpoint example
 */
async function apiGetUsers(req, res) {
  try {
    // Get pagination params from query string
    // Example: /api/users?page=2&limit=20
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 20;

    // Get paginated results
    const result = await getPaginatedResults(page, limit);

    // Return JSON response
    res.json({
      success: true,
      ...result,
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: 'Server error',
      error: error.message,
    });
  }
}

/**
 * Advanced: Cursor-based pagination (better for large datasets)
 * Uses _id field instead of skip for better performance
 */
async function getPaginatedCursor(lastId = null, limit = 10) {
  const query = lastId ? { _id: { $gt: lastId } } : {};

  const results = await Address.find(query)
    .sort({ _id: 1 }) // Important for cursor pagination
    .limit(limit);

  return {
    data: results,
    nextCursor: results.length > 0 ? results[results.length - 1]._id : null,
  };
}

// ==================== PERFORMANCE CONSIDERATIONS ====================
/**
 * WARNING: Skip/Limit Pagination Issues:
 *
 * Problem 1: Performance degrades with large skip values
 *   - skip(100000) still scans all 100000 documents
 *
 * Problem 2: Inconsistent results if data changes
 *   - Documents added/deleted between page requests
 *
 * Solutions:
 * 1. For small datasets (<10K): Use skip/limit (simple)
 * 2. For large datasets: Use cursor-based pagination
 * 3. Add index on sort field for better performance
 */

// ==================== INDEXING FOR PAGINATION ====================
/**
 * Always add indexes for paginated queries!
 * Example: If you sort by createdAt, create an index:
 */
async function createPaginationIndexes() {
  // Index for sorting by creation date
  await Address.collection.createIndex({ createdAt: -1 });

  // Compound index for common filters + sort
  await Address.collection.createIndex({
    status: 1, // Filter field
    createdAt: -1, // Sort field
  });
}

// ==================== COMMON PAGINATION PATTERNS ====================
const paginationPatterns = {
  // Pattern 1: Simple page-based (what we implemented)
  simple: async (page, limit) => {
    const skip = (page - 1) * limit;
    return await Address.find({}).skip(skip).limit(limit);
  },

  // Pattern 2: With filtering
  filtered: async (page, limit, filters = {}) => {
    const skip = (page - 1) * limit;
    return await Address.find(filters).skip(skip).limit(limit);
  },

  // Pattern 3: With sorting
  sorted: async (page, limit, sortBy = { createdAt: -1 }) => {
    const skip = (page - 1) * limit;
    return await Address.find({}).sort(sortBy).skip(skip).limit(limit);
  },

  // Pattern 4: Full implementation with count
  full: async (page, limit, filters = {}, sortBy = { createdAt: -1 }) => {
    const skip = (page - 1) * limit;

    const [data, total] = await Promise.all([
      Address.find(filters).sort(sortBy).skip(skip).limit(limit),
      Address.countDocuments(filters),
    ]);

    return {
      data,
      total,
      page,
      limit,
      totalPages: Math.ceil(total / limit),
    };
  },
};

// ==================== USAGE EXAMPLES ====================
/**
 * Example 1: Basic pagination
 */
async function example1() {
  const page1 = await paginationPatterns.simple(1, 10);
  const page2 = await paginationPatterns.simple(2, 10);
}

/**
 * Example 2: Filtered pagination
 */
async function example2() {
  // Get page 1 of active users from New York
  const activeNYUsers = await paginationPatterns.filtered(1, 20, {
    status: 'active',
    city: 'New York',
  });
}

/**
 * Example 3: Sorted pagination
 */
async function example3() {
  // Get latest users first
  const latestUsers = await paginationPatterns.sorted(
    1,
    20,
    { createdAt: -1 }, // Newest first
  );
}

// ==================== TEST DATA SETUP ====================
/**
 * Helper function to create test data for pagination
 */
async function createTestData() {
  console.log('Creating test data for pagination demo...');

  const testAddresses = [];
  for (let i = 1; i <= 50; i++) {
    testAddresses.push({
      userId: 100 + Math.floor(i / 10), // Groups of 10 users
      name: `User ${i}`,
      city: i % 2 === 0 ? 'New York' : 'Los Angeles',
      createdAt: new Date(Date.now() - i * 1000 * 60 * 60), // Staggered times
      orderNumber: `ORD${String(i).padStart(6, '0')}`,
    });
  }

  await Address.insertMany(testAddresses);
  console.log(`Created ${testAddresses.length} test documents`);
}

// ==================== MAIN EXECUTION ====================
// Run the main function
run().catch(console.error);

/**
 * SUMMARY OF KEY CONCEPTS:
 *
 * 1. Pagination = Breaking data into pages
 * 2. Formula: skip = (page - 1) × limit
 * 3. skip() = How many documents to skip
 * 4. limit() = How many documents to return
 * 5. Always calculate total pages for UI
 * 6. Consider performance implications
 * 7. Use indexes for better performance
 * 8. For large datasets, consider cursor-based pagination
 */
