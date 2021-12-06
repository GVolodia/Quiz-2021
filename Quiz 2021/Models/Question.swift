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
            Answer(text: "Рыбу", type: .cat),
            Answer(text: "Стейк", type: .dog),
            Answer(text: "Морковку", type: .rabbit),
            Answer(text: "Кукурузу", type: .turtle),
        ]),
        Question(text: "Что вы любите делать?", type: .multiple, answers: [
            Answer(text: "Плавать", type: .turtle),
            Answer(text: "Есть", type: .dog),
            Answer(text: "Спать", type: .cat),
            Answer(text: "Обниматься", type: .rabbit),
        ]),
        Question(text: "Любите ли вы поездки на машине?", type: .range, answers: [
            Answer(text: "Ненавижу", type: .cat),
            Answer(text: "Нервничаю", type: .rabbit),
            Answer(text: "Не замечаю", type: .turtle),
            Answer(text: "Обожаю", type: .dog),
        ]),
    ]
}
