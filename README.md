# Funda flutter assignment

![funda_no_network](https://user-images.githubusercontent.com/1181883/139067997-0eb36a7f-79d7-462c-ab39-cb73967dcebc.gif)
![funda_404_case](https://user-images.githubusercontent.com/1181883/139068202-06a25410-69c9-4f2d-bf2f-7c0acd945389.gif)


## About

Application is implemented with BLoC architecture, where Cubit is chosen as a base class for blocs.


#### Notice:
- I use either/option here along with my own extensions, cause I think it's a nice approach and I want to share it with you :)
- Unit test ✓
- Local data source is not practivally used, but it's to show off repo pattern. It's also tested, so can be quickly brought to live.
- I didn't use @freezed in this project, but u can see I am somewhat accustomed to it. Do

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
