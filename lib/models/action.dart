import 'package:flutter/material.dart';
import 'package:motor_flutter_starter/pages/actions_page.dart';

enum ActionItem {
  schema,
  bucket,
  document,
}

extension ActionItemExt on ActionItem {
  Widget get page {
    return ActionsPage(item: this);
  }

  String get title {
    switch (this) {
      case ActionItem.schema:
        return 'Schema';
      case ActionItem.bucket:
        return 'Bucket';
      case ActionItem.document:
        return 'Document';
    }
  }

  IconData get icon {
    switch (this) {
      case ActionItem.schema:
        return Icons.table_chart;
      case ActionItem.bucket:
        return Icons.cloud;
      case ActionItem.document:
        return Icons.description;
    }
  }

  String get description {
    switch (this) {
      case ActionItem.schema:
        return 'Manage your type definitions on the Sonr Blockchain';
      case ActionItem.bucket:
        return 'Manage user storage and access for Buckets';
      case ActionItem.document:
        return 'Create, update, delete documents';
    }
  }
}
