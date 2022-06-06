library constants;

import 'dart:convert';

const String BASE_URL = "https://api.sojiare.com/v1/";

// http client constants
var headers = <String, String>{
  "Accept": "application/x-www-form-urlencoded",
  'Content-Type': 'application/x-www-form-urlencoded',
  'app_key': 'vvv'
};




// secure storage keys
const String CHECK_LOGIN_STATUS = "loginstatus";
const String SESSION_ID = "session_id";
const String SESSION_TOKEN = "session_token";
const String LOGGED_IN_USER = "user";



// API fetch paths
const String SIGN_UP = BASE_URL + "authe/signup";
const String SIGN_IN = BASE_URL + "authe/login";
const String SEARCH_EMAILS = BASE_URL + "search_engine/search_emails";
const String SEARCH_PHONE = BASE_URL + "search_engine/search_phones";
const String GET_USER_SEARCHES = BASE_URL + "users/get_all_user_searches";
const String GET_USER_REQUESTS = BASE_URL + "user/requests/";
const String SAVE_SEARCH = BASE_URL + "suspected_users/save_seaches";
const String FLAG_PHONE = BASE_URL + "search_engine/flag_phone_numer";
const String FLAG_EMAIL = BASE_URL + "search_engine/flag_email";
const String VERIFY_PHONE = BASE_URL + "search_engine/verify_phone_number";
const String VERIFY_EMAIL = BASE_URL + "search_engine/verify_email";

const String GET_USER_ITEM_RELATIONSHIP = BASE_URL + "item/relationship/";

const String GET_ITEM_BY_CATEGORY = BASE_URL +  "items/";
const String GET_HOME_DATA = BASE_URL +  "home";




