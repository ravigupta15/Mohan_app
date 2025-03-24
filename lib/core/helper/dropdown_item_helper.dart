import 'package:flutter/material.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/model/invoice_items_model.dart';
import 'package:mohan_impex/features/home_module/complaint_claim/model/invoice_model.dart';
import 'package:mohan_impex/features/home_module/custom_visit/new_customer_visit/model/unv_customer_model.dart';
import 'package:mohan_impex/features/home_module/kyc/model/segment_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/district_model.dart';
import 'package:mohan_impex/features/home_module/requisitions/journey_plan/model/state_model.dart';

class DropdownItemHelper {

   List<DropdownMenuItem<String>> stateItems(List<StateItems> list) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final item in list) {
      menuItems.addAll(
        [
          DropdownMenuItem(
            value: item.name,
            child: Text(
              item.name,
            ),
          ),
          if (item != list.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }


  List<DropdownMenuItem<String>> districtItems(List<DistrictItem> list) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final item in list) {
      menuItems.addAll(
        [
          DropdownMenuItem(
            value: item.district,
            child: Text(
              item.district??'',
            ),
          ),
          if (item != list.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

 List<DropdownMenuItem<String>> dropdownListt(list) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final item in list) {
      menuItems.addAll(
        [
          DropdownMenuItem(
            value: item,
            child: Text(
              item,
            ),
          ),
          if (item != list.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }
List<DropdownMenuItem<String>> unvCustomerList(List<UNVModel> list) {
  final List<DropdownMenuItem<String>> menuItems = [];

  if (list.isEmpty) {
    menuItems.add(
      const DropdownMenuItem<String>(
        value: null, // No value when empty
        child: Text(
          'No found',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  } else {
    for (final item in list) {
      menuItems.add(DropdownMenuItem(
        value: item.name,
        child: Text(item.name ?? ''),
      ));
      
      if (item != list.last) {
        menuItems.add(const DropdownMenuItem<String>(
          enabled: false,
          child: Divider(),
        ));
      }
    }
  }

  return menuItems;
}



List<DropdownMenuItem<String>> segmentList(List<SegmentItemModel> list) {
  final List<DropdownMenuItem<String>> menuItems = [];

  if (list.isEmpty) {
    menuItems.add(
      const DropdownMenuItem<String>(
        value: null, // No value when empty
        child: Text(
          'No found',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  } else {
    for (final item in list) {
      menuItems.add(DropdownMenuItem(
        value: item.name,
        child: Text(item.name ?? ''),
      ));
      
      if (item != list.last) {
        menuItems.add(const DropdownMenuItem<String>(
          enabled: false,
          child: Divider(),
        ));
      }
    }
  }

  return menuItems;
}

List<DropdownMenuItem<String>> invoiceList(List<invoiceListModel> list) {
  final List<DropdownMenuItem<String>> menuItems = [];

  if (list.isEmpty) {
    menuItems.add(
      const DropdownMenuItem<String>(
        value: null, // No value when empty
        child: Text(
          'Not found',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  } else {
    for (final item in list) {
      menuItems.add(DropdownMenuItem(
        value: item.name,
        child: Text(item.name ?? ''),
      ));
      
      if (item != list.last) {
        menuItems.add(const DropdownMenuItem<String>(
          enabled: false,
          child: Divider(),
        ));
      }
    }
  }

  return menuItems;
}



List<DropdownMenuItem<String>> invoiceItemList(List<InvoiceItemRecords> list) {
  final List<DropdownMenuItem<String>> menuItems = [];

  if (list.isEmpty) {
    menuItems.add(
      const DropdownMenuItem<String>(
        value: null, // No value when empty
        child: Text(
          'Select item',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  } else {
    for (final item in list) {
      menuItems.add(DropdownMenuItem(
        value: item.itemName,
        child: Text(item.itemName ?? ''),
      ));
      
      if (item != list.last) {
        menuItems.add(const DropdownMenuItem<String>(
          enabled: false,
          child: Divider(),
        ));
      }
    }
  }

  return menuItems;
}


}