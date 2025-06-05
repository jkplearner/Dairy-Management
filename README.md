# 🥛 Dairy Management System - Salesforce DX Project

This is a Salesforce DX project built to manage dairy inventory, suppliers, product sales, and expiry notifications using Lightning Web Components (LWC), Apex classes, and custom Salesforce metadata.

## 🔧 Project Overview

The **Dairy Management System** is a streamlined Salesforce application that enables efficient tracking and management of dairy products, their inventory levels, suppliers, and revenue analytics. It’s designed for suppliers and administrators to:

- 📦 Add and manage dairy products
- 📈 Visualize revenue statistics and inventory trends
- ⏰ Receive expiry notifications for perishable items
- 🧾 Track supplier details and product catalog
- 🔍 View all data in an intuitive Lightning App UI

## ⚙️ Core Features

- **Lightning Web Components (LWC)**:
  - `addDairyProduct` – Add new dairy products
  - `inventoryTracker` – Monitor product inventory
  - `supplierDashboard` – Supplier overview and management
  - `productCatalog` – List and search products
  - `revenueChart` – Revenue analytics and visualization
  - `expirynotification` – Alerts for expiring products

- **Apex Controllers**:
  - `DairyProductController`
  - `InventoryController`
  - `RevenueController`
  - `SupplierController`
  - `ProductController`
  - `ExpiryController`

- **Custom Objects**:
  - `Dairy_Product__c`
  - `Inventory__c`
  - `Supplier__c`
  - `Sales__c`, and more...

- **Triggers**:
  - `InventoryTrigger` – Auto updates inventory upon changes

## 🛠️ Local Development Setup

To set this up locally using Salesforce CLI:

```bash
git clone https://github.com/your-username/dairy-management.git
cd dairy-management
npm install
sfdx force:org:create -s -f config/project-scratch-def.json -a dairyMgmt
sfdx force:source:push
sfdx force:org:open
