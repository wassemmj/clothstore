import 'package:flutter/cupertino.dart';
import 'package:myproject/core/constant/imageasset.dart';
import 'package:myproject/data/model/onboardingmodel.dart';

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      title: "Find the item you've been\nlooking for",
      body: "Here you'll see rich varieties of goods,carefully \n classified for seamless browsing experience.",
      image: AppImageAsset.onBoardingImageOne),
  OnBoardingModel(
      title: "Add any item you want or Save it  ",
      body: "add any item you want to your cart,or save it on \n your wishlist,so you don't miss it in your future \n purchases.",
      image: AppImageAsset.onBoardingImageTwo),
  OnBoardingModel(
      title: "Fast & Source payment\n ",
      body: "There ara many payment options available for \n your easy.",
      image: AppImageAsset.onBoardingImageThree),
  OnBoardingModel(
      title: "Package Tracking",
      body: "in particular, Shoplon can pack your orders,and \n help you seamlessy manage your shipments.",
      image: AppImageAsset.onBoardingImageOne)


];
