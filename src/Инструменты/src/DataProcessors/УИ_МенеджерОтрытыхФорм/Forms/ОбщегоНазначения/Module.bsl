// @strict-types


#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Параметры, "ВспомогательныеЗначения");

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Вспомогательные значения.
// 
// Возвращаемое значение:
//  см. ОбработкаОбъект.УИ_МенеджерОтрытыхФорм.НовыйВспомогательныеЗначения
&НаКлиенте
Функция ВспомогательныеЗначения() Экспорт
	
	Возврат ВспомогательныеЗначения;
	
КонецФункции

// см. ОбработкаОбъект.УИ_МенеджерОтрытыхФорм.ПолныйПутьКФормеОбработки
&НаКлиенте
Функция ПолныйПутьКФормеОбработки(ИмяФормыОбработки) Экспорт
	
	Возврат СтрШаблон("%1.Форма.%2", ВспомогательныеЗначения().Метаданные.ПолноеИмя, ИмяФормыОбработки);
	
КонецФункции

#КонецОбласти