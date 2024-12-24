import 'package:get/get.dart';
import 'package:library_user_app/common/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response, {bool showToaster = true}) {
    String message;

    // Check if the response has a message
    if(response.statusCode == 500){
      message = "Internal server error. Please try later.";
    } else if (response.body != null && response.body['message'] != null) {
      message = response.body['message'];
    } else {
      // Handle different status codes with default messages
      switch (response.statusCode) {
        case 200:
          message = "Request was successful.";
          break;
        /*case 201:
          message = "Resource was created successfully.";
          break;*/
        case 204:
          message = "No content to display.";
          break;
        case 400:
          message = "Bad request. Please try again.";
          break;
        case 401:
          message = "Unauthorized access. Please log in.";
          break;
        case 403:
          message = "Forbidden. You don't have permission.";
          break;
        case 404:
          message = "Resource not found.";
          break;
        case 500:
          message = "Internal server error. Please try later.";
          break;
        case 502:
          message = "Bad gateway. Please try later.";
          break;
        case 503:
          message = "Service unavailable. Please try later.";
          break;
        default:
          message = "Unexpected error occurred.";
      }
    }

    if (showToaster) {
      showCustomSnackBar(message, showToaster: showToaster);
    }
  }
}

