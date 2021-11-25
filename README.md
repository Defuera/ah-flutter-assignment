# Ah flutter assignment

![ah_no_network](https://user-images.githubusercontent.com/1181883/139067997-0eb36a7f-79d7-462c-ab39-cb73967dcebc.gif)
![ah_404_case](https://user-images.githubusercontent.com/1181883/139068202-06a25410-69c9-4f2d-bf2f-7c0acd945389.gif)


## About

Application is implemented with BLoC architecture, where Cubit is chosen as a base class for blocs.


#### Notice:
- Usage of either/option along with my own extensions, I find it quite a clear and concise approach for  error propagation:)
- Unit tests ✓
- Local data source not practically used, rather implement to present power of repository pattern.
- I didn't use @freezed in this project, but u can see I am somewhat accustomed to it.

#### Known flows:
- Using one model between Network and Domain layers 😱
- Using a bit of a random icons for living area and ground area, hope u don't mind 🤷‍♀️
- I didn't do proper text styling, just added TextStyleExtension for consistence. Didn't want to bother without having a UI kit
- Was lazy to parse ur data format, so no dates in the app
- API key is hardcoded, should be injected, preferably on CI 🔑
- Image placeholder is missing
- Didn't implement localization

I don't think solving above tasks would show skill too much, so I omitted it to save time.
I invested in what is more important imo - architecture, scalability and code clarity.
UI is also ok-ish I think 😊

## Running

### Tests
 `flutter test --coverage`

### App
`flutter run`
