# Ah flutter assignment

## About

Application is implemented with BLoC architecture, where Cubit is chosen as a base class for blocs.
First page is loading collection 10 items per page. Second page is art object detailed and it's displayed in two steps:
1. Display thumb item, which is loaded as part of list
2. Load and display detailed item
Given issue with detailed API you can notice that thumb and detailed items are different, I hope u will excuse this imperfection.



https://user-images.githubusercontent.com/1181883/143874658-0e0b8e96-c585-4d54-a2f9-87ced737ddee.mp4



#### Notice:

- Usage of either/option along with my own extensions, I find it quite a clear and concise approach for  error propagation:)
- Usage of mock data source to mock broken detailed api
- When failed to load next list page error widget is shown with retry button


#### Known flows:

- Using one model between Network and Domain layers 😱
- API key is hardcoded, should be injected, preferably on CI 🔑
- Didn't implement localization
- Not showing per page loader indicator in the bottom of the page

I don't think solving above tasks would show skill too much, so I omitted it to save time.
I invested in what is more important imo - architecture, scalability and code clarity.
UI is also ok-ish I think 😊

## Running

### Tests
 `flutter test --coverage`

### App
`flutter run`
