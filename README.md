# Ah flutter assignment

![ah_no_network](https://user-images.githubusercontent.com/1181883/139067997-0eb36a7f-79d7-462c-ab39-cb73967dcebc.gif)
![ah_404_case](https://user-images.githubusercontent.com/1181883/139068202-06a25410-69c9-4f2d-bf2f-7c0acd945389.gif)


## About

Application is implemented with BLoC architecture, where Cubit is chosen as a base class for blocs.
First page is loading collection 10 items per page. Second page is art object detailed and it's displayed in two steps:
1. Display thumb item, which is loaded as part of list
2. Load and display detailed item
Given issue with detailed API you can notice that thumb and detailed items are different, I hope u will excuse this imperfection.



#### Notice:
- Usage of either/option along with my own extensions, I find it quite a clear and concise approach for  error propagation:)
- Usage of mock data source to mock broken detailed api

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
