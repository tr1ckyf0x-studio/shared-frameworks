// Created by Dmitry Stavitsky on 29/07/23

public protocol MapsValue<Input, Output> {
    associatedtype Input
    associatedtype Output

    /// Сущность, описывающая алгоритм преобразования из одного типа в другой
    /// - Parameter object: Исходный тип объекта
    /// - Returns: Преобразованный тип объекта
    func mapValue(from object: Input?) -> Output
}
