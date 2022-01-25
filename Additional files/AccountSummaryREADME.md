# AccountSummary

____

## Описание

Первый экран из tabBarList __[MainViewContoller](https://github.com/Olegajaro/BankeyApp/blob/main/BankeyApp/MainViewController.swift)__. 
Представляет собой таблицу __[AccountSummaryViewController](https://github.com/Olegajaro/BankeyApp/blob/main/BankeyApp/AccountSummary/AccountSummaryViewController.swift)__, в которой размещена информация о счетах клиента на его банковском аккаунте. Данные об аккаунте приходят из сети.

___

## Особенности

____

### TableViewCell, tableHeaderView
Для того, чтобы сделать таблицу более информативной, реализованы 2 кастомных элемента для хэдера и ячейки таблицы:

+ __[AccountSummaryHeaderView](https://github.com/Olegajaro/BankeyApp/blob/main/BankeyApp/AccountSummary/Header/AccountSummaryHeaderView.swift)__ - header таблицы реализован с помощью xib файла.
+ __[AccountSummaryCell](https://github.com/Olegajaro/BankeyApp/blob/main/BankeyApp/AccountSummary/Cells/AccountSummaryCell.swift)__ - ячейка таблицы реализованна программно.

Данные классы имеют дополнительные предсталения __(viewModel)__, в которых созданы модели с данными для отображения, которые помещаются в соотетствующий класс, избавляя его от лишней ответственности.

____

### CurrencyFormatter
Для отображения баланса счетов в аккаунте так же применено кастомное решение в виде структуры __[CurrencyFormatter](https://github.com/Olegajaro/BankeyApp/blob/main/BankeyApp/Utils/CurrencyFormatter.swift)__.

____

### Networking
В хэдере таблицы отображаются данные о профиле клиента, а в ячейке данные об аккаунте конкретного клиента. Они берутся из одного JSON файла, но по 2 разным URL. 
Поэтому работа с сетью разделена на две части, получение профиля и получение аккаунта по его id. __[ProfileManager](https://github.com/Olegajaro/BankeyApp/blob/main/BankeyApp/AccountSummary/Networking/ProfileManager.swift)__, __[Расширение для AccountSummaryViewController](https://github.com/Olegajaro/BankeyApp/blob/main/BankeyApp/AccountSummary/AccountSummaryViewController%20%2B%20Networking.swift)__(fetch Accounts).
    
    Протокол ProfileManageable на который подписан ProfileManager нужен для создания мок объекта для тестирования (см. Раздел UnitTests).
    
При работе с сетью так же используется __GCD__, __DispatchQueue.main.async__ для отображения полученных данных в основном потоке и __DispatchGroup__ для синхронного отображения данных в хэдере и ячейке при загрузке и рефреше данных.

____

### UIRefreshControl
Для данного экрана реализована возможность получить данные случайного пользователя (1 из 4) при помощи обновления данных через __UIRefreshControl__.

![refresh](https://media.giphy.com/media/Zul4ZowNMjw2usuap9/giphy.gif)

____

### ErrorAlert
Если при загрузке данных из сети произойдет ошибка, то с помощью alertController пользователь будет уведомлен о проблемах с получением данных или сбоем в сети.
Для каждой ошибки будет показано определенное название и сообщение. Тип ошибок содержится в перечислении __NetworkError__.

![errorAlert](https://media.giphy.com/media/UAcxaAFGue9GHUIZQ4/giphy.gif)






