
#Область ПрограммныйИнтерфейс

// Заменить переменные в тексте.
// 
// Параметры:
//  Исходник - Строка - Исходник
//  ЗаменяемыеПеременные -Структура Из КлючИЗначение:
//  	* Ключ - Строка - текущее имя переменной
//  	* Значение - Строка - Новое имя переменной
// 
// Возвращаемое значение:
//  Строка
Функция ЗаменитьПеременныеВТексте(Исходник, ЗаменяемыеПеременные) Экспорт
	ПараметрыПлагинов = Новый Структура;
	ПараметрыПлагинов.Вставить("ПереименованиеПеременных", ЗаменяемыеПеременные);
	Возврат РезультатИзмененияТекста(Исходник, ПараметрыПлагинов);

КонецФункции

// Установить директивы компиляции у методов модуля.
// 
// Параметры:
//  Исходник - Строка -Исходник
//  Директива - Строка - Директива. &НаКлиенте, &НаСервере и т.п.
// 
// Возвращаемое значение:
//  Строка - Установить директивы компиляции у методов модуля
Функция УстановитьДирективыКомпиляцииУМетодовМодуля(Исходник, Директива) Экспорт
	ПараметрыПлагинов = Новый Структура;
	ПараметрыПлагинов.Вставить("УстановкаДирективКомпиляцииУМетодовМодуля", Директива);
	Возврат РезультатИзмененияТекста(Исходник, ПараметрыПлагинов);
КонецФункции

// Выполнить изменение текста.
// 
// Параметры:
//  Исходник -Строка -Исходник
//  ПараметрыПлагинов - Структура Из КлючИЗначение:
//  	* Ключ - Строка - Имя плагина
//  	* Значение - Произвольный - Параметры плагина
// 
// Возвращаемое значение:
//  Строка
Функция РезультатИзмененияТекста(Исходник, ПараметрыПлагинов) Экспорт
	РезультатОбработки = ОбработатьМодульСИспользованиемПлагинов(Исходник, ПараметрыПлагинов);
	
	Замены = РезультатОбработки.Парсер.ТаблицаЗамен();
	Если Замены.Количество() > 0 Тогда
		Возврат РезультатОбработки.Парсер.ВыполнитьЗамены();
	КонецЕсли;
	
	Возврат Исходник;	
КонецФункции

// Результаты обработки текста.
// 
// Параметры:
//  Исходник - Строка - Исходник
//  ПараметрыПлагинов - Структура Из КлючИЗначение:
//  	* Ключ - Строка - Имя плагина
//  	* Значение - Произвольный - Параметры плагина
// 
// Возвращаемое значение:
//  Массив из Произвольный - Результаты обработки текста
// Возвращаемое значение:
// 	Неопределено - Обработка текста выполнена неудачно
Функция РезультатыОбработкиТекста(Исходник, ПараметрыПлагинов) Экспорт
	РезультатОбработки = ОбработатьМодульСИспользованиемПлагинов(Исходник, ПараметрыПлагинов);

	Возврат РезультатОбработки.РезультатыОбработки;	
КонецФункции

// Структура модуля.
// 
// Параметры:
//  Исходник - Строка - Исходник
// 
// Возвращаемое значение:
//  Структура:
//  	* Переменные - Массив из Строка
//  	* Методы - Массив из Строка
//  	* ЕстьБлокИнициализации - Булево
// Возвращаемое значение:
// 	Неопределено - Получение структуры было неудачным
Функция СтруктураМодуля(Исходник) Экспорт
	ПараметрыПлагинов = Новый Структура;
	ПараметрыПлагинов.Вставить("ПолучениеСтруктурыМодуля", Неопределено);
	РезультатОбработки = ОбработатьМодульСИспользованиемПлагинов(Исходник, ПараметрыПлагинов);
	
	Если РезультатОбработки.РезультатыОбработки = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;

	Возврат РезультатОбработки.РезультатыОбработки[0];
КонецФункции

// Текст модуля обработк исполнения алгоритма.
// 
// Параметры:
//  ТекстАлгорритма - Строка -
//  ИменаПредустановленныхПеременных - Массив из Строка -
//  ИсполнениеНаКлиенте - Булево - Исполнение на клиенте. Если истина будет сгенерирован код модуля формы, 
//  	иначе код модуля обработки
// 
// Возвращаемое значение:
//  Строка
Функция ТекстМодуляОбработкиИсполненияАлгоритма(ТекстАлгорритма, ИменаПредустановленныхПеременных ,ИсполнениеНаКлиенте) Экспорт
	СтруктураМодуля = СтруктураМодуля(ТекстАлгорритма);
	
	ПараметрыПлагинов = Новый Структура;
	Если ИсполнениеНаКлиенте Тогда
		ПараметрыПлагинов.Вставить("УстановкаДирективКомпиляцииУМетодовМодуля", "&НаКлиенте");
	КонецЕсли;
	
	ПараметрыПлагинаДоработкиТекстаАлгоритма = Новый Структура;
	ПараметрыПлагинаДоработкиТекстаАлгоритма.Вставить("ИсполнениеНаКлиенте", ИсполнениеНаКлиенте);
	ПараметрыПлагинаДоработкиТекстаАлгоритма.Вставить("ИменаПеременных", ИменаПредустановленныхПеременных);
	ПараметрыПлагинаДоработкиТекстаАлгоритма.Вставить("СтруктураМодуля", СтруктураМодуля);
	ПараметрыПлагинов.Вставить("ДоработкаТекстаАлгоритмаДляОбработки", ПараметрыПлагинаДоработкиТекстаАлгоритма);
	
	Возврат РезультатИзмененияТекста(ТекстАлгорритма, ПараметрыПлагинов);
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Обработать модуль с использованием плагинов.
// 
// Параметры:
//  Исходник - Строка - Исходник
//  ПараметрыПлагинов - Структура Из КлючИЗначение:
//  	* Ключ - Строка - Имя плагина
//  	* Значение - Произвольный - Параметры плагина
// 
// Возвращаемое значение:
//  Структура - Обработать модуль с использованием плагинов:
// * РезультатыОбработки - Массив из Произвольный, Неопределено -
// * Парсер - ОбработкаОбъект.УИ_ПарсерВстроенногоЯзыка -
Функция ОбработатьМодульСИспользованиемПлагинов(Исходник, ПараметрыПлагинов)
	Парсер = Обработки.УИ_ПарсерВстроенногоЯзыка.Создать();
	
	Плагины = Новый Массив();
	ПараметрыПлагиновИсполнения = Новый Соответствие;

	Для Каждого КлючЗначение Из ПараметрыПлагинов Цикл
		ТекПлагин = НовыйПлагинПарсераВстроенногоЯзыка(КлючЗначение.Ключ);
		
		Плагины.Добавить(ТекПлагин);
		ПараметрыПлагиновИсполнения[ТекПлагин.ЭтотОбъект] = КлючЗначение.Значение;
	КонецЦикла;

	Попытка
		РезультатыОбработки = Парсер.Пуск(Исходник, Плагины, ПараметрыПлагиновИсполнения);
	Исключение
		РезультатыОбработки = Неопределено;
	КонецПопытки;
		
	СтруктураРезультатаОбработки = Новый Структура;
	СтруктураРезультатаОбработки.Вставить("РезультатыОбработки", РезультатыОбработки);
	СтруктураРезультатаОбработки.Вставить("Парсер", Парсер);
	
	Возврат СтруктураРезультатаОбработки;	
	
КонецФункции

// Новый плагин парсера встроенного языка.
// 
// Параметры:
//  ИмяПлагина - Строка - Имя плагина
// 
// Возвращаемое значение:
//  ВнешняяОбработка
// Возвращаемое значение:
//  Неопределено - Не удалось подключить плагин
Функция НовыйПлагинПарсераВстроенногоЯзыка(ИмяПлагина)
	ИмяПодключаемойОбработки = ИмяПодключаемойОбработкиПлагинаПарсераВстроенногоЯзыка(ИмяПлагина);
	Если Метаданные.Обработки.Найти(ИмяПодключаемойОбработки) <> Неопределено Тогда
		Возврат Обработки[ИмяПодключаемойОбработки].Создать();
	КонецЕсли;
	
	Попытка
		Возврат ВнешниеОбработки.Создать(ИмяПодключаемойОбработки);
	Исключение
		Попытка
			ПодключитьПлагинКСеансу(ИмяПлагина);
			Возврат ВнешниеОбработки.Создать(ИмяПодключаемойОбработки);
		Исключение
			Возврат Неопределено;
		КонецПопытки;
	КонецПопытки;
КонецФункции

// Подключить плагин к сеансу.
// 
// Параметры:
//  ИмяПлагина -Строка -Имя плагина
Процедура ПодключитьПлагинКСеансу(ИмяПлагина)
	ДвоичныеДанныеПлагина = Обработки.УИ_ПарсерВстроенногоЯзыка.ПолучитьМакет("Плагин_" + ИмяПлагина);
	АдресПлагинаВоВременномХранилище = ПоместитьВоВременноеХранилище(ДвоичныеДанныеПлагина);

	УИ_ОбщегоНазначения.ПодключитьВнешнююОбработкуКСеансу(АдресПлагинаВоВременномХранилище,
														  ИмяПодключаемойОбработкиПлагинаПарсераВстроенногоЯзыка(ИмяПлагина));

КонецПроцедуры

Функция ИмяПодключаемойОбработкиПлагинаПарсераВстроенногоЯзыка(ИмяПлагина)
	Возврат ПрефиксПодключаемойОбработкиПлагина()+"_"+ВРег(ИмяПлагина);	
КонецФункции

Функция ПрефиксПодключаемойОбработкиПлагина()
	Возврат "УИ_ПлагинПарсераВстроенногоЯзыка";
КонецФункции

#КонецОбласти
