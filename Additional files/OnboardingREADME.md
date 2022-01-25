# OnboardingView

____

## Описание

Экран - контейнер с дополнительной информацией, появляющийся при первом запуске приложения.

### Особенности 

Для реализации __Onboadrding__ создан переиспульзуемый __ContainerViewController__, в который можно подставить нужное изображение и описание, при создании экземпляра данного класса.
Сам "контейнер" реализован в классе __OnboardingContainerViewController__ при помощи __UIPageViewController__, в который добавлены 3 экземпяра класса __ContainerViewController__.
Подробно смотрите в коде __[здесь](https://github.com/Olegajaro/BankeyApp/blob/main/BankeyApp/Onboarding/OnboardingContainerViewController.swift).__

Навигация осуществляется 3 способами:
+ Точечным меню снизу
+ Кнопками next, back, close и done
+ Свайпами по экрану

Закрыть и попасть на главный экран можно с помощью кнопки close или кнопки done на последнем экране Onboarding.

![onboading](https://media.giphy.com/media/gaBuHtU0PaFv2wXySq/giphy.gif)
