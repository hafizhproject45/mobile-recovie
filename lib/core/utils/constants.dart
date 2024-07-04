// ignore_for_file: constant_identifier_names

const String BASE_HTTP = 'https://';
const String BASE_URL = 'https://api.themoviedb.org/3';
const String IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
const String IMAGE_PLACEHOLDER =
    'https://via.placeholder.com/80x100.png?text=No+Image';
const String BASE_DOMAIN = 'api.themoviedb.org';

//! API ENDPOINT

const String MOVIE = '/movie/';
const String SEARCH_MOVIE = '/search/movie';
const String POPULAR_LIST = '/movie/popular';
const String NOW_PLAYING_LIST = '/movie/now_playing';
const String TOP_RATED_LIST = '/movie/top_rated';
const String UPCOMING_LIST = '/movie/upcoming';
const String TRENDING_LIST = '/trending/movie/week';

//! Exception messages
const String EXCEPTION_CANCEL = 'Permintaan ke server dibatalkan';
const String EXCEPTION_CONNECTION_RTO = 'Waktu koneksi habis';
const String EXCEPTION_RECEIVE_RTO = 'Receive timeout in connection';
const String EXCEPTION_SEND_RTO = 'Send timeout in connection';
const String EXCEPTION_OTHER = 'Gagal terhubung ke server';
const String EXCEPTION_NOT_FOUND = 'Data tidak ditemukan';
const String EXCEPTION_METHOD = 'Resource tidak ditemukan';
const String EXCEPTION_MEDIA_TYPE = 'Unsupported media type';
const String EXCEPTION_ISE = 'Internal server error';
const String EXCEPTION_UNAUTHORIZED = 'Silahkan login kembali';
const String EXCEPTION_UNKNOWN = 'Terjadi Kesalahan';
const String EXCEPTION_AUTH_INVALID = 'Username atau password salah';

//! Failure Messages
const String FAILURE_UNKNOWN = 'Terjadi Kesalahan';
const String FAILURE_USER_CACHE = 'Error get cache';
const String FAILURE_MAP_DISABLED = 'Pemindai lokasi tidak aktif';
const String FAILURE_MAP_DENIED = 'Izin mengakses lokasi ditolak';
const String FAILURE_MAP_DENIED_FOREVER =
    'Izin mengakses lokasi diblokir permanen';
const String FAILURE_UPLOAD_PICTURE = 'Gagal mengambil gambar';
const String FAILURE_UPLOAD_FILE = 'Batal mengambil file';

//! Network info
const String MESSAGE_UNCONNECTED = 'Tidak terhubung ke Internet';
const String MESSAGE__CONNECTED = 'Terhubung ke Internet';

//! Hive Key
const String LOGIN_DATA_BOX = 'LOGIN_DATA_BOX';
const String LOGIN_DATA_ID = 'LOGIN_DATA_ID';
const String OFFICE_DATA_BOX = 'OFFICE_DATA_BOX';
const String OFFICE_DATA_ID = 'OFFICE_DATA_ID';

//! Date Locale
const String DATE_LOCALE = 'id';

//! Pagination Limit
const int LIMIT = 10;
