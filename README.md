
---

## 📦 Packages

### SBViews (UI Layer)
- SwiftUI views and reusable components  
- Examples:
  - SBTransactionListView  
  - SBTransactionRowView  
  - SBCardView  
  - SBLabelValueSection  
  - SBMoreOrLessView  

---

### SBProcess (Orchestration Layer)
- Implements business flow via repository pattern  
- Coordinates data between local and remote sources  
- Example:
  - SBTransactionRepositoryImpl  

---

### SBDomain (Core Layer)
- Pure models and contracts (no external dependencies)  
- Examples:
  - SBTransaction  
  - SBMoney  
  - SBTransactionType  
  - SBTransactionRepository  
  - SBTransactionLocalRepository  
  - SBTransactionRemoteService  

---

### SBLocal (Persistence Layer)
- Local storage implementations  
- Supports:
  - In-memory storage  
  - SwiftData persistence  
- Includes mapping between domain, entity, and record  

---

### SBNetwork (Remote Layer)
- DTO models and mapping logic  
- Stub-based service for predictable testing  
- Examples:
  - SBTransactionDTO  
  - SBTransactionDTOMapper  
  - SBStubTransactionRemoteService  
  - SBJSONResourceLoader  

---

## 🔄 Data Flow

1. UI triggers data load via SBProcess  
2. Local storage is checked first (fast rendering)  
3. Remote data is fetched using `since` strategy  
4. Data is mapped to domain models  
5. Local storage is updated  
6. UI refreshes with latest state  

---

## ⚙️ Key Design Principles

- ✅ Separation of concerns  
- ✅ Dependency inversion (UI depends on abstractions)  
- ✅ Swappable data sources (local + remote)  
- ✅ Testable architecture  
- ✅ Reusable UI components  

---

## 🚀 Getting Started

### Requirements
- iOS 17+  
- Xcode 26+  

### Run the App
1. Clone the repository  
2. Open the project in Xcode  
3. Build and run on simulator or device


---

## 🧪 Testing

- Stub-based network layer enables predictable testing  
- In-memory repository available for fast unit tests  
- Designed for easy extension of test coverage  

---

## 🔜 Future Improvements

- 🌐 Real API integration  
- 🔎 Search and filtering  
- 📄 Pagination support  
- 🌙 Enhanced dark mode  
- ✅ Expanded unit and UI tests  

---

## 💡 Why This Project?

This app demonstrates:
- Clean architecture in a real-world scenario  
- Modular Swift Package design  
- Scalable and maintainable code structure  
- Thoughtful handling of data flow and state  

---

## 👨‍💻 Author

Built as part of a modern iOS architecture exploration and portfolio project.
