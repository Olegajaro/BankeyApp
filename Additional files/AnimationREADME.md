# Aimations

____


## Анимированные объекты в приложении

+ Маленький колокольчик в headerView таблицы главного экрана. Анимация происходит каждый раз при нажатии на объект.
+ Мерцающее представление ввиде "каркаса" для отображаемых данных в ячейке таблицы. Его можно увидеть при долгой загрузке данных из сети, появлении ошибок или долгом обновлении при помощи refreshControl. 

![shakeyBell](https://media.giphy.com/media/vkVX46y19T5owBBqT3/giphy.gif) ![skeletonView](https://media.giphy.com/media/kelHjkenET1fCc3vCO/giphy.gif)

___


## Реализация анимаций

### ShakeyBell
Для анимированного колокольчика создан отдельный класс __ShakeBellView__ в дирекетории Components.
Анимированный объект представляет собой __UIImageView__, для которого с помощью __UITapGestureRecognizer__ добавлено действие по нажатию. 
Анимация представляет собой 6 смещений на угол 22.5 (-22.5) градуса в течении 1.0 секунды относительно __imageView.setAnchorPoint(CGPoint(x: 0.5, y: 0.0))__.
```swift
extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(
            x: bounds.size.width * point.x,
            y: bounds.size.height * point.y
        )
        var oldPoint = CGPoint(
            x: bounds.size.width * layer.anchorPoint.x,
            y: bounds.size.height * layer.anchorPoint.y
        )
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = point
    }
}

    @objc func imageViewTapped() {
        shakeWith(duration: 1.0, angle: .pi / 8, yOffset: 0.0)
    }
    
    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        let numberOfFrames = 6.0
        let frameDuration = 1 / numberOfFrames
        
        imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: []) {
            UIView.addKeyframe(
                withRelativeStartTime: 0.0,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration * 2,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration * 3,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration * 4,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration * 5,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform.identity
            }
        }
    }
```

### SkeletonView

SkeletonView представляет собой дополнительное представление, которое по своей сути повторяет ячейку AccountSummaryCell. 
Появляется оно только при ошибках в сети или долгой подгрузке данных. Анимируется в данном варианте измение цвета __CAGradienLayer__, который добавляется к каждому лейблу. Реализация происходит при помощи __CAAnimationGroup__, __CABasicAnimation__ и метода в протоколе __SkeletonLoadable__, на который будет подписан класс __[SkeletonCell](https://github.com/Olegajaro/BankeyApp/blob/main/BankeyApp/AccountSummary/Cells/SkeletonCell.swift)__.
Для эффекта рассинхрона смены цветов, начало анимации каждого следующего объекта будет через 0.33 секунды.

```swift
extension SkeletonLoadable {
    
    func makeAnimationGroup(
        previousGroup: CAAnimationGroup? = nil
    ) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5
        
        let animation1 = CABasicAnimation(
            keyPath: #keyPath(CAGradientLayer.backgroundColor)
        )
        animation1.fromValue = UIColor.gradientLightGrey.cgColor
        animation1.toValue = UIColor.gradientDarkGrey.cgColor
        animation1.duration = animDuration
        animation1.beginTime = 0.0
        
        let animation2 = CABasicAnimation(
            keyPath: #keyPath(CAGradientLayer.backgroundColor)
        )
        animation2.fromValue = UIColor.gradientDarkGrey.cgColor
        animation2.toValue = UIColor.gradientLightGrey.cgColor
        animation2.duration = animDuration
        animation2.beginTime = animation1.beginTime + animation1.duration
        
        let group = CAAnimationGroup()
        group.animations = [animation1, animation2]
        group.repeatCount = .greatestFiniteMagnitude // infinite
        group.duration = animation2.beginTime + animation2.duration
        group.isRemovedOnCompletion = false
        
        if let previousGroup = previousGroup {
            // Offset groups by 0.33 seconds for effect
            group.beginTime = previousGroup.beginTime + 0.33
        }
        
        return group
    }
}
```











