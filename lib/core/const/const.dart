// base_host.dart

// Replace this with your production backend URL when deployed
// const String baseHost = "http://localhost:8080";
// const baseHost = "https://trendybacked-5p38.onrender.com";
const baseHost = "https://api.trendy-c.com";
// const String baseHost = "https://trendybacked.onrender.com";

// ────────────── Authentication ──────────────
const String googleAdminLoginEndpoint = "$baseHost/auth/google-admin";

// ────────────── Admin Core ──────────────
const String adminsEndpoint = "$baseHost/admin/admins";
const String adminUsersEndpoint = "$baseHost/admin/users";

// ────────────── Admin Management ──────────────
const String adminManagementEndpoint = "$baseHost/admin/admin-management";
const String adminPendingAdminsEndpoint = "$adminManagementEndpoint/pending";
const String adminApproveAdminEndpoint = "$adminManagementEndpoint/approve";
const String adminRejectAdminEndpoint = "$adminManagementEndpoint/reject";

// ────────────── Product Management ──────────────
const String adminProductsEndpoint = "$baseHost/admin/products";
const String adminProductExcelEndpoint = "$adminProductsEndpoint/import-excel";
const String adminProductExportExcelEndpoint =
    "$adminProductsEndpoint/export-excel";

// ────────────── Category Management ──────────────
const String adminCategoriesEndpoint = "$baseHost/admin/categories";

// ────────────── Banner Management ──────────────
const String adminBannerUploadEndpoint = "$baseHost/admin/banner/upload";
const String adminBannerListEndpoint = "$baseHost/admin/banner/";

// ────────────── Order Management ──────────────

const String orderEndpoint = "$baseHost/orders/";
// ────────────── user cart view ──────────────

const String userCartEndpoint = "$baseHost/admin/user-cart/";

// ────────────── API Key ──────────────
const String apiKey = "trendyMm2030Mm";
