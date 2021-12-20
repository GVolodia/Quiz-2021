//
//  Question.swift
//  Quiz 2021
//
//  Created by noone on 12/6/21.
//

struct Question {
    let text: String
    let type: ResponseType
    let answers: [Answer]
    
    static let all: [Question] = [
        Question(text: "Какую еду вы предпочитаете?", type: .single, answers: [
            Answer(text: "Рыбку", type: .tahiti),
            Answer(text: "Мясо!!", type: .greenland),
            Answer(text: "Вообще-то я - веган.", type: .karelia),
            Answer(text: "Чипсы и кола!", type: .city),
            Answer(text: "Я ем все!", type: .australia),
        ]),
        Question(text: "Что вам больше нравится?", type: .multiple, answers: [
            Answer(text: "Океан", type: .tahiti),
            Answer(text: "Горы", type: .greenland),
            Answer(text: "Лес", type: .karelia),
            Answer(text: "Степь", type: .australia),
            Answer(text: "Лишь бы не дома", type: .city),
        ]),
        Question(text: "Любите ли вы экскурсии?", type: .range, answers: [
            Answer(text: "Гугл - лучший экскурсовод", type: .tahiti),
            Answer(text: "Нервничаю", type: .karelia),
            Answer(text: "Не замечаю", type: .australia),
            Answer(text: "Обожаю", type: .greenland),
            Answer(text: "Без них отдых - не отдых", type: .city),
        ]),
        Question(text: "Какой климат вам по душе?", type: .segment, answers: [
            Answer(text: "Ветер", type: .australia),
            Answer(text: "Дождь", type: .karelia),
            Answer(text: "Облачно", type: .city),
            Answer(text: "Солнце", type: .tahiti),
            Answer(text: "Снег", type: .greenland),
        ]),
    ]
}
