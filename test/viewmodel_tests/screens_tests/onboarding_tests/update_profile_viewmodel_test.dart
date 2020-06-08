import 'package:flutter_test/flutter_test.dart';

import 'package:paperplane/screens/onboarding/update_profile_screen/update_profile_viewmodel.dart';

void main() {
  group("- UpdateProfileViewModel tests", () {
    group("isButtonVisible -", () {
      test(
        "When the name is empty",
        () {
          UpdateProfileViewModel updateProfileViewModel =
              UpdateProfileViewModel();

          expect(updateProfileViewModel.isButtonVisible, false);
        },
      );

      test(
        "When the name is 3 letters long",
        () {
          UpdateProfileViewModel updateProfileViewModel =
              UpdateProfileViewModel();

          updateProfileViewModel.setName("abc");
          expect(updateProfileViewModel.isButtonVisible, false);
        },
      );

      test(
        "When the first name is 3 letters long and the last name is 2 letters long",
        () {
          UpdateProfileViewModel updateProfileViewModel =
              UpdateProfileViewModel();

          updateProfileViewModel.setName("abc ab");
          expect(updateProfileViewModel.isButtonVisible, true);
        },
      );

      test(
        "When the name is more than 3 letters",
        () {
          UpdateProfileViewModel updateProfileViewModel =
              UpdateProfileViewModel();

          updateProfileViewModel.setName("abcd");
          expect(updateProfileViewModel.isButtonVisible, true);
        },
      );
    });
  });
}
