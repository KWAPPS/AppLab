import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_app/screens/in_app/reviews.dart';
import 'package:connect_app/screens/in_app/profile_screen.dart';

FirebaseFirestore _firestore = Firestore.instance;
FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

class ReviewHandling {
  void postReview(
      String reviewText, bool userAlreadyReviewed, String emailOfReviewee) {
    _firestore.collection('reviews').add({
      'reviewText': reviewText,
      'emailOfReviewee': emailOfReviewee,
      'reviewerEmail': _firebaseAuth.currentUser.email,
      'numberOfStars': starRating == null ? '3.5' : starRating,
      'firstName': _firebaseAuth.currentUser.email.split('@')[0]
    });
    print('review posted______ $reviewText');
  }

  void upDateReview(String reviewID, String newReviewText) {
    _firestore.collection('reviews').doc(reviewID).update({
      'reviewText': newReviewText,
      'numberOfStars': starRating == null ? '3.5' : starRating,
    });

    print('review updated ______ $newReviewText');
  }
}
