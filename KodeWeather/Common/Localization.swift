//
//  Localization.swift
//  KodeWeather
//
//  Created by Igor Podolskiy on 21.10.2020.
//

enum Localization {
    enum Search {
        static let title = "Погода"
        static let searchBarPlaceholder = "Поиск"
        static let searchBarCancelButtonText = "Отменить"
        static let headerSearchUserDefaults = "Последние запросы"
        static let headerSearch = "Похожие запросы"
        static let headerSearchNoResults = "Такого города не существует"
    }
    enum Weather {
        static let title = "Погода в городе"
        static let attractionsButtonTitle = "Достопримечетальности"
        static let todayForecast = "Сегодня"
        static let tomorrowForecast = "Завтра"
    }
    enum Attractions {
        static let title = "Достопримечательности"
    }
    enum AttractionDetail {
        static let readMoreTitle = "Читать дальше"
        static let mapTitle = "На карте"
    }
    enum Common {
        static let confirmButtonTitle = "Хорошо"
        static let errorDescription = "При выполнении запроса произошла ошибка, проверьте подключение к интернету и повторите запрос"
    }
}
