## 🛠 Тестовое задание (осенняя стажировка в KODE)

**Комментарий для проверяющего**

Здравствуйте. Я изначально хотел реализовать выдачу промежуточных вариантов поиска с использованием какого-то соотвествующего бэкэнда. Нативный MKLocalSearchCompleter не позволяет установить фильтрацию результатов поиска по населенный пунктам, поэтому ошибочно определив, что сервис Яндекс Геокодер позволяет делать такую фильтрацию, я реализовал поиск результатов с помощью него. Однако уже позже я понял, что, к сожалению, данный сервис позволяет делать фильтрацию только для обратного геокодирования. Сервис Google позволяет указывать фильтр по городам при запросе, но, к сожалению, там всего 100 бесплатных запросов в день и обязательная привязка банковской карты для получения apikey. Я все же реализовал поиск через MKLocalSearchCompleter и так и не опредев какая из моих реализаций лучше оставил возможность использования оба варианта:

Yandex Geocoder: 

(минусы) фильтрация по типу уже после получения ответа, плохая релевантность промежуточных результатов 

(плюсы) получение координат сразу, почти гарантированное получение результата при полном вводе названия
                
 MKLocalSearchCompleter: 
 
 (минусы) необходимость обратного геокодирования для получения координат, из за специфики фильтрации результатов нет гарантии того, что вы найдете нужный город, тестил его один день 
 
 (плюсы) хорошая релевантность промежуточных результатов

*Чтобы выбрать какой бэкэнд используется в приложении, необходимо в файле AppSettings.swift (находится в корне папки проекта) записать необходимое значение* 

```swift
static let searchBackend: SearchBackend = .yandex 
```
 *или*
 ```swift
static let searchBackend: SearchBackend = .mkLocalSearch
```

**Города с достопримечательностями: Калининград, Берлин, Вильнюс, Минск, Санкт-Петербург**

## 📸 Screenshots

<p align="center">
  <strong>Live preview (4.7 MB)</strong> <br />
  <img src="https://user-images.githubusercontent.com/18668589/97268100-09665700-1834-11eb-93a5-f4c9668bb5c5.gif" />
</p>

