&НаКлиенте
Перем ЗакрытиеФормыПодтверждено;

#Область СобытияФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	UT_CodeEditorServer.ФормаПриСозданииНаСервере(ЭтотОбъект);
	UT_CodeEditorServer.СоздатьЭлементыРедактораКода(ЭтотОбъект, "Сервер", Элементы.ПолеАлгоритмаСервер);
	UT_CodeEditorServer.СоздатьЭлементыРедактораКода(ЭтотОбъект, "Клиент", Элементы.ПолеАлгоритмаКлиент);
	
	UT_Common.ФормаИнструментаПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка, Элементы.ОсновнаяКоманднаяПанель);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	Если Не ЗакрытиеФормыПодтверждено Тогда
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура OnOpen(Отказ)
	UT_CodeEditorClient.FormOnOpen(ЭтотОбъект, Новый ОписаниеОповещения("ПриОткрытииЗавершение",ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура ПеременныеСерверПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	ДобавитьДополнительныйКонтекстВРедакторКода("Сервер");
КонецПроцедуры

&НаКлиенте
Процедура ПеременныеКлиентПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	ДобавитьДополнительныйКонтекстВРедакторКода("Клиент");
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ПолеРедактораДокументСформирован(Элемент)
	UT_CodeEditorClient.HTMLEditorFieldDocumentGenerated(ЭтотОбъект, Элемент);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ПолеРедактораПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	UT_CodeEditorClient.HTMLEditorFieldOnClick(ЭтотОбъект, Элемент, ДанныеСобытия, СтандартнаяОбработка);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_РедакторКодаОтложеннаяИнициализацияРедакторов()
	UT_CodeEditorClient.CodeEditorDeferredInitializingEditors(ЭтотОбъект);
КонецПроцедуры

&НаКлиенте 
Процедура Подключаемый_РедакторКодаЗавершениеИнициализации() Экспорт
	Если ЗначениеЗаполнено(AlgorithmFileName) Тогда
		UT_CommonClient.ReadConsoleFromFile("КонсольКода", СтруктураОписанияСохраняемогоФайла(),
			Новый ОписаниеОповещения("ОткрытьФайлЗавершение", ЭтотОбъект), Истина);
	Иначе
		УстановитьТекстРедактора("Клиент", ТекстАлгоритмаКлиент);
		УстановитьТекстРедактора("Сервер", ТекстАлгоритмаСервер);
	КонецЕсли;
КонецПроцедуры


#КонецОбласти

#Область СобытияКомандФормы
&НаКлиенте
Процедура ЗакрытьКонсоль(Команда)
	ПоказатьВопрос(Новый ОписаниеОповещения("ЗакрытьКонсольЗавершение", ЭтаФорма), "Выйти из консоли кода?",
		РежимДиалогаВопрос.ДаНет);
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьКод(Команда)
	//.1 Нужно обновить значения данных алгоритмов
	ОбновитьЗначениеПеременныхАлгоритмовИзРедактора();

	СтруктураПередачи = Новый Структура;
	ВыполнитьАлгоритмНаКлиенте(СтруктураПередачи);
	ВыполнитьАлгоритмНаСервере(СтруктураПередачи);
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьЗначениеКлиентскойПеременной(Команда)
	РедактироватьЗначениеПеременной(Элементы.ПеременныеКлиент);
КонецПроцедуры

&НаКлиенте
Процедура РедактироватьЗначениеСервернойПеременной(Команда)
	РедактироватьЗначениеПеременной(Элементы.ПеременныеСервер);
КонецПроцедуры

&НаКлиенте
Процедура НовыйАлгоритм(Команда)
	AlgorithmFileName="";

	ТекстАлгоритмаКлиент="";
	ТекстАлгоритмаСервер="";

	УстановитьТекстРедактора("Клиент",ТекстАлгоритмаКлиент);
	УстановитьТекстРедактора("Сервер",ТекстАлгоритмаСервер);

	УстановитьЗаголовок();
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФайл(Команда)
	UT_CommonClient.ReadConsoleFromFile("КонсольКода", СтруктураОписанияСохраняемогоФайла(),
		Новый ОписаниеОповещения("ОткрытьФайлЗавершение", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФайл(Команда)
	СохранитьФайлНаДиск();
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФайлКак(Команда)
	СохранитьФайлНаДиск(Истина);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ВыполнитьОбщуюКомандуИнструментов(Команда) 
	UT_CommonClient.Attachable_ExecuteToolsCommonCommand(ЭтотОбъект, Команда);
КонецПроцедуры

#КонецОбласти

#Область ПрочиеФункции

&НаКлиенте
Функция ПеременныеКонтекста(ТЧПеременных)
	МассивПеременных=Новый Массив;
	Для Каждого ТекПеременная Из ТЧПеременных Цикл
		СтруктураПеременной=Новый Структура;
		СтруктураПеременной.Вставить("Имя", ТекПеременная.Имя);
		СтруктураПеременной.Вставить("Тип", ТипЗнч(ТекПеременная.Value));

		МассивПеременных.Добавить(СтруктураПеременной);
	КонецЦикла;
	
	Возврат МассивПеременных;
КонецФункции

&НаКлиенте
Процедура ДобавитьДополнительныйКонтекстВРедакторКода(ИдентификаторРедактора)
	СтруктураДополнительногоКонтекста = Новый Структура;
	СтруктураДополнительногоКонтекста.Вставить("СтруктураПередачи", "Структура");
	
	Если ИдентификаторРедактора = "Клиент" Тогда
		ТЧПеременных = ClientVariables;
	Иначе
		ТЧПеременных = ServerVariables;
	КонецЕсли;
	
	ПеременныеКонтекста =ПеременныеКонтекста(ТЧПеременных); 
	Для Каждого Пер Из ПеременныеКонтекста Цикл
		Если Не UT_CommonClientServer.IsCorrectVariableName(Пер.Имя) Тогда
			Продолжить;
		КонецЕсли;
		
		СтруктураДополнительногоКонтекста.Вставить(Пер.Имя, Пер.Тип);
	КонецЦикла;
	
	UT_CodeEditorClient.AddCodeEditorContext(ЭтотОбъект, ИдентификаторРедактора, СтруктураДополнительногоКонтекста);
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытииЗавершение(Результат, ДополнительныеПараметры) Экспорт

КонецПроцедуры

&НаКлиенте
Функция СтруктураОписанияСохраняемогоФайла()
	Структура=UT_CommonClient.EmptyDescriptionStructureOfSelectedFile();
	Структура.ИмяФайла=AlgorithmFileName;

	UT_CommonClient.AddFormatToSavingFileDescription(Структура, "Файл алгоритма(*.xbsl)", "xbsl");
	Возврат Структура;
КонецФункции

&НаКлиенте
Процедура СохранитьФайлНаДиск(СохранитьКак = Ложь)
	ОбновитьЗначениеПеременныхАлгоритмовИзРедактора();

	UT_CommonClient.SaveConsoleDataToFile("КонсольКода", СохранитьКак,
		СтруктураОписанияСохраняемогоФайла(), ПолучитьСтрокуСохранения(),
		Новый ОписаниеОповещения("СохранитьФайлЗавершение", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФайлЗавершение(ИмяФайлаСохранения, ДополнительныеПараметры) Экспорт
	Если ИмяФайлаСохранения = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если Не ЗначениеЗаполнено(ИмяФайлаСохранения) Тогда
		Возврат;
	КонецЕсли;

	Модифицированность=Ложь;
	AlgorithmFileName=ИмяФайлаСохранения;
	УстановитьЗаголовок();
	
//	Сообщить("Алгоритм успешно сохранен");

КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФайлЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Модифицированность=Ложь;
	AlgorithmFileName = Результат.ИмяФайла;

	ОткрытьАлгоритмНаСервере(Результат.Адрес);

	УстановитьТекстРедактора("Клиент",ТекстАлгоритмаКлиент);
	УстановитьТекстРедактора("Сервер",ТекстАлгоритмаСервер);

	УстановитьЗаголовок();
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьКонсольЗавершение(Результат, ДополнительныеПараметры) Экспорт

	Если Результат = КодВозвратаДиалога.Да Тогда
		ЗакрытиеФормыПодтверждено = Истина;
		Закрыть();
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ОбработчикОжиданияУстановитьТекстКодаВРедактореТекстаКлиент()
	Попытка
		УстановитьТекстРедактора("Клиент",ТекстАлгоритмаКлиент);
	Исключение
		ПодключитьОбработчикОжидания("ОбработчикОжиданияУстановитьТекстКодаВРедактореТекстаКлиент", 0.5, Истина);
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
Процедура ОбработчикОжиданияУстановитьТекстКодаВРедактореТекстаСервер()
	Попытка
		УстановитьТекстРедактора("Сервер",ТекстАлгоритмаСервер);
	Исключение
		ПодключитьОбработчикОжидания("ОбработчикОжиданияУстановитьТекстКодаВРедактореТекстаСервер", 0.5, Истина);
	КонецПопытки;
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьЗначениеПеременныхАлгоритмовИзРедактора()
	ТекстАлгоритмаКлиент=UT_CodeEditorClient.EditorCodeText(ЭтотОбъект, "Клиент");
	ТекстАлгоритмаСервер=UT_CodeEditorClient.EditorCodeText(ЭтотОбъект, "Сервер");
КонецПроцедуры

&НаКлиенте
Процедура УстановитьТекстРедактора(ИдентификаторРедактора, ТекстАлгоритма)
	UT_CodeEditorClient.SetEditorText(ЭтотОбъект, ИдентификаторРедактора, ТекстАлгоритма);
	ДобавитьДополнительныйКонтекстВРедакторКода(ИдентификаторРедактора);	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция КонтекстВыполненияАлгоритма(Переменные, СтруктураПередачи)
	КонтекстВыполнения = Новый Структура;
	КонтекстВыполнения.Вставить("СтруктураПередачи", СтруктураПередачи);

	Для Каждого СтрокаТЧ ИЗ Переменные Цикл
		КонтекстВыполнения.Вставить(СтрокаТЧ.Имя, СтрокаТЧ.Value);
	КонецЦикла;

	Возврат КонтекстВыполнения;	
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ПодготовленныйКодАлгоритма(ТекстКода, Переменные)
	ПодготовленныйКод="";

	Для НомерПеременной = 0 По Переменные.Количество() - 1 Цикл
		ТекПеременная=Переменные[НомерПеременной];
		ПодготовленныйКод=ПодготовленныйКод + Символы.ПС + ТекПеременная.Имя + "=Переменные[" + Формат(НомерПеременной,
			"ЧН=0; ЧГ=0;") + "].Значение;";
	КонецЦикла;

	ПодготовленныйКод=ПодготовленныйКод + Символы.ПС + ТекстКода;

	Возврат ПодготовленныйКод;
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция ВыполнитьАлгоритм(ТекстАлготима, Переменные, СтруктураПередачи)
	Успешно = Истина;
	ОписаниеОшибки = "";

	НачалоВыполнения = ТекущаяУниверсальнаяДатаВМиллисекундах();
	Попытка
		Выполнить (ТекстАлготима);
	Исключение
		Успешно = Ложь;
		ОписаниеОшибки = ОписаниеОшибки();
		Сообщить(ОписаниеОшибки);
	КонецПопытки;
	ОкончаниеВыполнения = ТекущаяУниверсальнаяДатаВМиллисекундах();

	РезультатВыполнения = Новый Структура;
	РезультатВыполнения.Вставить("Успешно", Успешно);
	РезультатВыполнения.Вставить("ВремяВыполнения", ОкончаниеВыполнения - НачалоВыполнения);
	РезультатВыполнения.Вставить("ОписаниеОшибки", ОписаниеОшибки);

	Возврат РезультатВыполнения;
КонецФункции

&НаКлиенте
Процедура ВыполнитьАлгоритмНаКлиенте(СтруктураПередачи)
	Если Не ЗначениеЗаполнено(СокрЛП(ТекстАлгоритмаКлиент)) Тогда
		Возврат;
	КонецЕсли;

	КонтекстВыполнения = КонтекстВыполненияАлгоритма(ClientVariables, СтруктураПередачи);

	РезультатВыполнения = UT_CodeEditorClientServer.ВыполнитьАлгоритм(ТекстАлгоритмаКлиент, КонтекстВыполнения);

	Если РезультатВыполнения.Успешно Тогда
		ЗаголовокЭлемента = "&&НаКлиенте (Время выполнения кода: " + Строка((РезультатВыполнения.ВремяВыполнения)
			/ 1000) + " сек.)";
	Иначе
		ЗаголовокЭлемента = "&&НаКлиенте";
	КонецЕсли;
	Элементы.ГруппаКлиент.Заголовок = ЗаголовокЭлемента;

КонецПроцедуры

&НаСервере
Процедура ВыполнитьАлгоритмНаСервере(СтруктураПередачи)
	Если Не ЗначениеЗаполнено(СокрЛП(ТекстАлгоритмаСервер)) Тогда
		Возврат;
	КонецЕсли;
	
	КонтекстВыполнения = КонтекстВыполненияАлгоритма(ServerVariables, СтруктураПередачи);

	РезультатВыполнения = UT_CodeEditorClientServer.ВыполнитьАлгоритм(ТекстАлгоритмаСервер, КонтекстВыполнения);

	Если РезультатВыполнения.Успешно Тогда
		ЗаголовокЭлемента = "&&НаСервере (Время выполнения кода: " + Строка((РезультатВыполнения.ВремяВыполнения)
			/ 1000) + " сек.)";
	Иначе
		ЗаголовокЭлемента = "&&НаСервере";
	КонецЕсли;
	Элементы.ГруппаСервер.Заголовок = ЗаголовокЭлемента;

КонецПроцедуры

&НаСервере
Функция ПолучитьСтрокуСохранения()

	СохраняемыеДанные = Новый Структура;
	СохраняемыеДанные.Вставить("ТекстАлгоритмаКлиент", ТекстАлгоритмаКлиент);
	СохраняемыеДанные.Вставить("ТекстАлгоритмаСервер", ТекстАлгоритмаСервер);

	МассивПеременных=Новый Массив;
	Для Каждого ТекПеременная Из ClientVariables Цикл
		СтруктураПеременной=Новый Структура;
		СтруктураПеременной.Вставить("Имя", ТекПеременная.Имя);
		СтруктураПеременной.Вставить("Значение", ЗначениеВСтрокуВнутр(ТекПеременная.Value));

		МассивПеременных.Добавить(СтруктураПеременной);
	КонецЦикла;
	СохраняемыеДанные.Вставить("ClientVariables", МассивПеременных);

	МассивПеременных=Новый Массив;
	Для Каждого ТекПеременная Из ServerVariables Цикл
		СтруктураПеременной=Новый Структура;
		СтруктураПеременной.Вставить("Имя", ТекПеременная.Имя);
		СтруктураПеременной.Вставить("Значение", ЗначениеВСтрокуВнутр(ТекПеременная.Значение));

		МассивПеременных.Добавить(СтруктураПеременной);
	КонецЦикла;
	СохраняемыеДанные.Вставить("ServerVariables", МассивПеременных);

	ЗаписьJSON=Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку();

	ЗаписатьJSON(ЗаписьJSON, СохраняемыеДанные);

	Возврат ЗаписьJSON.Закрыть();

КонецФункции
&НаСервере
Процедура ОткрытьАлгоритмНаСервере(АдресФайлаВоВременномХранилище)
	ДанныеФайла=ПолучитьИзВременногоХранилища(АдресФайлаВоВременномХранилище);

	ЧтениеJSON=Новый ЧтениеJSON;
	ЧтениеJSON.ОткрытьПоток(ДанныеФайла.ОткрытьПотокДляЧтения());

	СтруктураФайла=ПрочитатьJSON(ЧтениеJSON);
	ЧтениеJSON.Закрыть();

	ТекстАлгоритмаКлиент=СтруктураФайла.ТекстАлгоритмаКлиент;
	ТекстАлгоритмаСервер=СтруктураФайла.ТекстАлгоритмаСервер;

	ClientVariables.Очистить();
	Для Каждого Переменная Из СтруктураФайла.ClientVariables Цикл
		НС=ClientVariables.Добавить();
		НС.Имя=Переменная.Имя;
		НС.Value=ЗначениеИзСтрокиВнутр(Переменная.Значение);
	КонецЦикла;

	ServerVariables.Очистить();
	Для Каждого Переменная Из СтруктураФайла.ServerVariables Цикл
		НС=ServerVariables.Добавить();
		НС.Имя=Переменная.Имя;
		НС.Значение=ЗначениеИзСтрокиВнутр(Переменная.Значение);
	КонецЦикла;

КонецПроцедуры
&НаКлиенте
Процедура РедактироватьЗначениеПеременной(ТаблицаФормы)
	ТекДанные=ТаблицаФормы.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	UT_CommonClient.EditObject(ТекДанные.Value);
КонецПроцедуры

&НаКлиенте
Процедура УстановитьЗаголовок()
	Заголовок=AlgorithmFileName;
КонецПроцедуры

&НаКлиенте
Процедура ПолеАлгоритмаСерверПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	// Вставить содержимое обработчика.
КонецПроцедуры



#КонецОбласти

ЗакрытиеФормыПодтверждено=Ложь;