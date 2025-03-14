# FetchProject

A SwiftUI-based recipe app that fetches and displays recipes from a remote API, focusing on **Swift Concurrency (async/await)**, **manual image caching**, and **unit testing**.

---

## **Screenshots**

![Simulator Screenshot - iPhone 16 Pro - 2025-03-14 at 08 54 32](https://github.com/user-attachments/assets/6a4d9d29-eca7-4088-a5f3-5784750cd2cf)
![Simulator Screenshot - iPhone 16 Pro - 2025-03-14 at 08 55 19](https://github.com/user-attachments/assets/04d88673-4048-46cc-ad7e-3e5e4c8d39c8)
![Simulator Screenshot - iPhone 16 Pro - 2025-03-14 at 08 56 16](https://github.com/user-attachments/assets/02ce1550-121e-4d97-bbce-b7f92d60bc20)

---

## **Summary**

FetchProject is a simple, single-screen **recipe app** that:
- Fetches recipes from a **remote API**.
- Displays each recipe’s **name, cuisine, and image**.
- Caches images **to disk** for efficient loading.
- Allows users to **refresh the recipe list**.

---

## **Focus Areas**
### **Key Priorities**
1. **Networking Efficiency**
   - Used **Swift Concurrency (async/await)** for API calls.
   - Ensured **graceful error handling** for empty/malformed data.
  
2. **Image Optimization**
   - Manually implemented **disk-based image caching**.
   - Avoided **redundant network requests**.

3. **Code Maintainability** 
   - Followed **SOLID principles** to keep the code modular.
   - Prioritized **clean, testable architecture**.

4. **Unit Testing** 
   - Focused on **testing API calls and caching logic**.
   - Ensured tests covered **core functionality**.

---

## **Time Spent**
### **Total Time: ~ 11 hours**
| **Task** | **Time Spent** |
|----------|--------------|
| Project setup & API integration | 2 hours |
| SwiftUI UI implementation | 2 hours |
| Image caching implementation | 3 hours |
| Writing unit tests | 2 hours |
| README & documentation | 2 hours |

---

## **Trade-offs and Decisions**
### **Key Trade-offs**
1. **Chose Disk Caching Over In-Memory Caching**  
   - **Reason:** Disk caching persists between app launches, whereas `NSCache` clears memory when the app closes.
   - **Impact:** First-time loads may take longer, but subsequent launches are faster.

2. **Focused on Unit Tests, Not UI Tests**  
   - **Reason:** The project requirements emphasized **core logic testing**.
   - **Impact:** UI tests were skipped, but API and caching logic is well-tested.

3. **Did Not Use Third-Party Libraries**  
   - **Reason:** The project constraints explicitly required no external dependencies.
   - **Impact:** Manual implementation of image caching and networking logic.

---

## **Weakest Part of the Project**
- **No UI/Integration Tests**  
  - While the API and caching logic are well-tested, there are **no UI tests** verifying SwiftUI behavior.
  
- **Limited Error Handling in UI**  
  - API failures and missing images are handled, but **the UI could provide more feedback** to the user.

---

## **Additional Information**
- **Future Improvements:**  
  - Add **in-memory caching (`NSCache`)** for even faster image retrieval.  
  - Implement **UI tests using XCTest**.  
  - Improve the UI with animations and better error messages.

- **Constraints Encountered:**  
  - The API had no pagination, requiring **all recipes to be loaded at once**.  
  - SwiftUI’s `List` caused some view reuse issues, which were resolved using `.id(\.uuid)`.  

---
