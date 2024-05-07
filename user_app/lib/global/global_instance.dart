

import 'package:logger/logger.dart';
import 'package:user_app/viewModel/address_view_model.dart';
import 'package:user_app/viewModel/auth_view_model.dart';
import 'package:user_app/viewModel/cart_view_model.dart';
import 'package:user_app/viewModel/common_view_model.dart';
import 'package:user_app/viewModel/home_view_model.dart';
import 'package:user_app/viewModel/item_view_model.dart';
import 'package:user_app/viewModel/menu_view_model.dart';
import 'package:user_app/viewModel/orders_view_model.dart';

CommonViewModel commonViewModel = CommonViewModel();
AuthViewModel authViewModel = AuthViewModel();
HomeViewModel homeViewModel = HomeViewModel();
MenuViewModel menuViewModel = MenuViewModel();
ItemViewModel itemViewModel = ItemViewModel();
CartViewModel cartViewModel = CartViewModel();
AddressViewModel addressViewModel = AddressViewModel();
OrderViewModel orderViewModel = OrderViewModel();
var log = Logger();