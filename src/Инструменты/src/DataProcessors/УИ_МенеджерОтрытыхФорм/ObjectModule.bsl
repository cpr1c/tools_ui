// @strict-types

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Сведения о внешней обработке
// 
// Возвращаемое значение:
//   см. ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке 
//
Функция СведенияОВнешнейОбработке() Экспорт
    
    Если Ложь Тогда
    	//@skip-check bsl-legacy-check-static-feature-access
    	ДополнительныеОтчетыИОбработки = ДополнительныеОтчетыИОбработки;
    	//@skip-check bsl-legacy-check-static-feature-access
    	ДополнительныеОтчетыИОбработкиКлиентСервер = ДополнительныеОтчетыИОбработкиКлиентСервер;
    КонецЕсли;
    
    ПараметрыРегистрации                    = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();
    ПараметрыРегистрации.Вид                = ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка();
    ПараметрыРегистрации.Версия             = НомерВерсииИнструмента();
    ПараметрыРегистрации.БезопасныйРежим    = Ложь;
    
    Команда = ПараметрыРегистрации.Команды.Добавить();
    Команда.Представление        = Метаданные().Представление();
    Команда.Идентификатор        = Метаданные().Имя;
    Команда.Использование        = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
    Команда.ПоказыватьОповещение = Ложь;
    
    Возврат ПараметрыРегистрации; 
    
КонецФункции

// Номер версии инструмента.
// 
// Возвращаемое значение:
//  Строка - Номер версии инструмента
Функция НомерВерсииИнструмента() Экспорт
    
    Возврат "0.6.1";
		
КонецФункции

// Новый вспомогательные значения.
// 
// Возвращаемое значение:
//  Структура:
// * Метаданные - см. НовыйМетаданныеИнструмента
// * ИзбранныеСсылки - Массив из Строка - Избранное пользователя
// * ПриставкаРеквизитовНастроек - Строка - Приставка для определения реквизитов, хранящих настройки обработки
// * РеквизитыНастроекФормы - Массив из Строка - Имена реквизитов, хранящих настройки обработки
// * СвойстваЭлементов - Массив из Строка - Имена свойств элементов, выводимых в дереве свойств
// * ИндексыКартинкиСтрокФорм - см. НовыйИндексыКартинкиСтрокФорм
// * ПараметрыРедактированияНастройкиФормы - Структура:
// ** СтарыеДанные - Неопределено, Структура - Старые данные редактирования настроек формы 
// * ЭлементыСКнопкамиПодсказки - Массив из Строка - Имена элементов с кнопками подсказки
// * КэшОписанийРеквизитовПоТипам - см. НовыйКэшОписанийРеквизитовПоТипам
// * КэшРеквизитовПоТипам - Соответствие из КлючИЗначение - TODO: А работает ли?
// * ТипыЭлементовПоИндексуКартинки - см. НовыйТипыЭлементовПоИндексуКартинки
// * СистемныеФормы - см. НовыйСистемныеФормы
Функция НовыйВспомогательныеЗначения() Экспорт
	
	Результат = Новый Структура;
	
	Результат.Вставить("Метаданные", НовыйМетаданныеИнструмента());
	
	Результат.Вставить("ИзбранныеСсылки", Новый Массив);
	Результат.Вставить("ПриставкаРеквизитовНастроек", "НастройкиОбработки_");
    
	//Реквизиты, которые содержат пользовательские настройки инструмента
	Результат.Вставить("РеквизитыНастроекФормы", Новый Массив);
	
	//Свойства элементов открытых форм
	Результат.Вставить("СвойстваЭлементов", Новый Массив);
	
	//Имена и заголовки системных форм платформы
	Результат.Вставить("СистемныеФормы", НовыйСистемныеФормы());
	
	//ИндексыКартинкиСтрокФорм
	Результат.Вставить("ИндексыКартинкиСтрокФорм", НовыйИндексыКартинкиСтрокФорм());
	
	//Сюды будут помещены старые данные при начале редактирования настроек из хранилища
	Результат.Вставить("ПараметрыРедактированияНастройкиФормы", Новый Структура);
	
	Результат.Вставить("ЭлементыСКнопкамиПодсказки",	Новый Массив);
	
	Результат.Вставить("КэшОписанийРеквизитовПоТипам", НовыйКэшОписанийРеквизитовПоТипам());
	
	Результат.Вставить("КэшРеквизитовПоТипам", Новый Соответствие);
	Результат.Вставить("ТипыЭлементовПоИндексуКартинки", НовыйТипыЭлементовПоИндексуКартинки());	
	
	Возврат Результат;
	
КонецФункции

// Описание метаданных этой обработки
// 
// Возвращаемое значение:
//  Структура:
// * Имя - Строка
// * ПолноеИмя - Строка
// * Представление - Строка
// * НомерВерсии - Строка
Функция НовыйМетаданныеИнструмента() Экспорт
	
	МетаданныеИнструмента = Метаданные();
	
	Результат = Новый Структура;
	Результат.Вставить("Имя"          , МетаданныеИнструмента.Имя);
	Результат.Вставить("ПолноеИмя"    , МетаданныеИнструмента.ПолноеИмя());
	Результат.Вставить("Представление", МетаданныеИнструмента.Представление());
	Результат.Вставить("НомерВерсии"  , НомерВерсииИнструмента());
	
	Возврат Результат;
	
КонецФункции

// Индексы картинок типов метаданных
// 
// Возвращаемое значение:
//  Структура:
// * Константа - Число
// * Справочник - Число
// * Документ - Число
// * ПланВидовХарактеристик - Число
// * ПланСчетов - Число
// * ПланВидовРасчета - Число
// * РегистрСведений - Число
// * РегистрНакопления - Число
// * РегистрБухгалтерии - Число
// * РегистрРасчета - Число
// * БизнесПроцесс - Число
// * Задача - Число
// * Отчет - Число
// * ВнешнийОтчет - Число
// * Обработка - Число
// * ВнешняяОбработка - Число
// * ВнешнийИсточникДанных - Число
// * ЖурналДокументов - Число
// * ПланОбмена - Число
// * ЭтаФорма - Число
// * ИсторияРаботы - Число
// * Избранное - Число
// * Системные - Число
Функция НовыйИндексыКартинкиСтрокФорм() Экспорт
	
	ИндексыКартинкиСтрокФорм = Новый Структура;
	ИндексыКартинкиСтрокФорм.Вставить("Константа", 1);
	ИндексыКартинкиСтрокФорм.Вставить("Справочник", 2);
	ИндексыКартинкиСтрокФорм.Вставить("Документ", 3);
	ИндексыКартинкиСтрокФорм.Вставить("ПланВидовХарактеристик", 4);
	ИндексыКартинкиСтрокФорм.Вставить("ПланСчетов", 5);
	ИндексыКартинкиСтрокФорм.Вставить("ПланВидовРасчета", 6);
	ИндексыКартинкиСтрокФорм.Вставить("РегистрСведений", 7);
	ИндексыКартинкиСтрокФорм.Вставить("РегистрНакопления", 8);
	ИндексыКартинкиСтрокФорм.Вставить("РегистрБухгалтерии", 9);
	ИндексыКартинкиСтрокФорм.Вставить("РегистрРасчета", 10);
	ИндексыКартинкиСтрокФорм.Вставить("БизнесПроцесс", 11);
	ИндексыКартинкиСтрокФорм.Вставить("Задача", 12);
	ИндексыКартинкиСтрокФорм.Вставить("Отчет", 13);
	ИндексыКартинкиСтрокФорм.Вставить("ВнешнийОтчет", 13);
	ИндексыКартинкиСтрокФорм.Вставить("Обработка", 14);
	ИндексыКартинкиСтрокФорм.Вставить("ВнешняяОбработка", 14);
	ИндексыКартинкиСтрокФорм.Вставить("ВнешнийИсточникДанных", 15);
	ИндексыКартинкиСтрокФорм.Вставить("ЖурналДокументов", 16);
	ИндексыКартинкиСтрокФорм.Вставить("ПланОбмена", 17);
	ИндексыКартинкиСтрокФорм.Вставить("ЭтаФорма", 18);
	ИндексыКартинкиСтрокФорм.Вставить("ИсторияРаботы", 19);
	ИндексыКартинкиСтрокФорм.Вставить("Избранное", 20);
	ИндексыКартинкиСтрокФорм.Вставить("Системные", 21);
	
	Возврат ИндексыКартинкиСтрокФорм;
	
КонецФункции

// Соответствие индекса картинки и типа элемента
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение:
//  * Ключ - Число - Индекс картинки
//  * Значение - Строка - Имя типа элемента
Функция НовыйТипыЭлементовПоИндексуКартинки() Экспорт
	
	ТипыЭлементовПоИндексуКартинки = Новый Соответствие();
	ТипыЭлементовПоИндексуКартинки.Вставить(0  , "");
	ТипыЭлементовПоИндексуКартинки.Вставить(1  , "КоманднаяПанель");
	ТипыЭлементовПоИндексуКартинки.Вставить(2  , "ТаблицаФормы");
	ТипыЭлементовПоИндексуКартинки.Вставить(3  , "КонтекстноеМеню");
	ТипыЭлементовПоИндексуКартинки.Вставить(4  , "РасширеннаяПодсказка");
	ТипыЭлементовПоИндексуКартинки.Вставить(5  , "ПолеФормы");
	ТипыЭлементовПоИндексуКартинки.Вставить(6  , "ДекорацияФормы");
	ТипыЭлементовПоИндексуКартинки.Вставить(7  , "Группа");
	ТипыЭлементовПоИндексуКартинки.Вставить(8  , "КнопкаФормы");
	ТипыЭлементовПоИндексуКартинки.Вставить(9  , "Расширение");
	ТипыЭлементовПоИндексуКартинки.Вставить(10 , "ОтображениеСтрокиПоиска");
	ТипыЭлементовПоИндексуКартинки.Вставить(11 , "ОтображениеСостоянияПросмотра");
	ТипыЭлементовПоИндексуКартинки.Вставить(12 , "УправлениеПоиском");
	
	Возврат ТипыЭлементовПоИндексуКартинки;	
	
КонецФункции

// Кэш хранит описания реквизитов для каждого типа
// 
// Возвращаемое значение:
//  Соответствие из КлючИЗначение:
//  * Ключ - Строка - Имя типа
//  * Значение - Структура - Кэш
Функция НовыйКэшОписанийРеквизитовПоТипам() Экспорт
	
	Результат = Новый Соответствие();
	
	ИменаТипов = "Число,Строка,Булево,Дата,Неопределено,Null";
	Для Каждого КлючИЗначение Из Новый Структура(ИменаТипов) Цикл
		Результат.Вставить(КлючИЗначение.Ключ, Новый Структура);
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Коллекция макетов инструмента.
// 
// Возвращаемое значение:
//  Массив из см. НовыйСистемнаяФорма;
Функция НовыйСистемныеФормы() Экспорт
	
	СистемныеФормы = Новый Массив;
	ЗаполнитьСистемныеФормы(СистемныеФормы);
	Возврат СистемныеФормы;	
	
КонецФункции

// Описание системной формы.
// 
// Возвращаемое значение:
//  Структура:
// * Имя - Строка
// * Заголовок - Строка 
Функция НовыйСистемнаяФорма() Экспорт
	
	Результат = Новый Структура;
	
	Результат.Вставить("Имя", "");
	Результат.Вставить("Заголовок", "");
	
	Возврат Результат;
	
КонецФункции

// Новый результат редактирования структуры соответствия.
// 
// Возвращаемое значение:
//  Структура:
// * ЗначениеРеквизита - Неопределено, Структура, Соответствие из КлючИЗначение - 
Функция НовыйРезультатРедактированияСтруктурыСоответствия() Экспорт
	
	Возврат Новый Структура("ЗначениеРеквизита", Неопределено);
	
КонецФункции

#Область ИнтерфейсФормыОбщегоНазначения

// Интерфейс формы общего назначения.
// 
// Возвращаемое значение:
//  ОбработкаОбъект.УИ_МенеджерОтрытыхФорм, ФормаКлиентскогоПриложения - обманка для того, чтобы описать методы формы
Функция ФормаОбщегоНазначения() Экспорт
	
	Возврат ЭтотОбъект;
	
КонецФункции

// Полный путь к форме обработки.
// 
// Параметры:
//  ИмяФормыОбработки - Строка
// 
// Возвращаемое значение:
//  Строка
Функция ПолныйПутьКФормеОбработки(ИмяФормыОбработки) Экспорт
	
	Возврат ""; //Интерфейс
	
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Параметры:
//  СистемныеФормы - см. НовыйСистемныеФормы
Процедура ЗаполнитьСистемныеФормы(СистемныеФормы)
	
	МакетСистемныеФормы = МакетСистемныхФорм();
	
	Для НомерСтроки = 1 По СтрЧислоСтрок(МакетСистемныеФормы) Цикл
		
		ТекущаяСтрока = СтрПолучитьСтроку(МакетСистемныеФормы, НомерСтроки);
		
		ЧастиСтроки = СтрРазделить(ТекущаяСтрока, ":");
		
		ИмяФормы = СокрЛП(ЧастиСтроки[0]);
		ЧастиСтроки.Удалить(0);
		
		Если ЗначениеЗаполнено(ЧастиСтроки) Тогда
			Заголовок = СтрШаблон("%1 (%2)", ИмяФормы, СокрЛП(ЧастиСтроки[0]));
		Иначе
			Заголовок = ИмяФормы;
		КонецЕсли;
		
		ОписаниеФормы = НовыйСистемнаяФорма();
		ОписаниеФормы.Имя = ИмяФормы;
		ОписаниеФормы.Заголовок = Заголовок;
		
		СистемныеФормы.Добавить(ОписаниеФормы);
		
	КонецЦикла;
	
КонецПроцедуры

Функция МакетСистемныхФорм()
	
	Возврат 
	"About"	
	"AllFunctionsForm:Все функции"
	"allmessages:Все сообщения"
	"BorderChoose:Выбор линии"
	"CertificateInfo"	
	"ChartAxis:Ось диаграммы"
	"ChartLabelArea:Настройка области подписи"
	"ChartPaletteDescription:Описание палитры цветов"
	"ChartRefBands:Информационные интервалы диаграммы"
	"ChartRefLines:Информационные линии диаграммы"
	"ChartScale"
	"ChartTypeChoose:Выбор типа диаграммы"
	"CMICustomization"
	"ColorChoose"
	"CryptoCertManager"
	"DataExchangeCreateInitialImage"
	"DataExchangeReadChanges:Чтение сообщения с изменениями"
	"DataExchangeWriteChanges"
	"DataHistoryChangeHistoryEnForm"
	"DataHistoryChangeHistoryRuForm"
	"DataHistoryUsersChooseDialog"
	"DataHistoryVersionDataEnForm"
	"DataHistoryVersionDataRuForm"
	"DataHistoryVersions"
	"DataHistoryVersionsFilterDialog"
	"DCSChartRefBand:Информационный интервал диаграммы"
	"DCSChartRefLine:Информационная линия диаграммы"
	"DesktopCustomization:Настройка начальной страницы"
	"diagGanttSets:Настройка"
	"ECSContextConvLargeMA"
	"ECSContextConvLargeMAv13"
	"ECSContextConvSmallMA"
	"ECSContextConvSmallMAv13"
	"ECSConvAddMA:Новое обсуждение"
	"ECSConvAddMAv13"
	"ECSConvMembersMA"
	"ECSConvMembersMAv13"
	"ECSConvTitleMA"
	"ECSFullUserInfoDlgMA"
	"ECSFullUserInfoDlgMAv13"
	"ECSInviteExtUser:Приглашение внешнего участника"
	"ECSMainForm:Обсуждения"
	"ECSMainFormMA:Обсуждения"
	"ECSMainFormMA2:Обсуждения"
	"ECSMainFormMA2v13"
	"ECSMainFormMAv13"
	"ECSRelatedMessagesForm:История сообщений"
	"ECSSettings:Настройки"
	"ECSSettingsMA:Настройки"
	"ECSUserInfoMA"
	"FavoritesDlg"
	"FavoritesDlgNew:Избранное"
	"fdSave:Сохранить"
	"FileNew:Выбор вида документа"
	"FontChoose:Выбор шрифта"
	"FontChooseDlgMobile"
	"formCustomization"
	"formCustomizationAddFields:Выберите поля для размещения в форме"
	"FormDataSettingsStorageLoadForm:Выбор параметров формы"
	"FormDataSettingsStorageSaveForm:Сохранение параметров"
	"fullscreen:Fullscreen"
	"GanttChartChoiceValue:Выбор"
	"Help:Справка"
	"HelpDlg:Выбор Главы"
	"HelpM:Справка"
	"HistoryDlg:История"
	"HistoryDlgNew:История"
	"ImageSize:Изменение размера картинки"
	"InsertHyperLink:Вставка гиперссылки"
	"InterStringInt:Междустрочный интервал"
	"itscredentials:Лицензирование конфигураций"
	"LineChoose:Выбор линии"
	"LockUserWorkForm:Система заблокирована (введите пароль)"
	"MessageBox"
	"moxelaccurateprint:Печатная форма подготовлена в формате PDF"
	"moxelColumnWidth"
	"moxelDeleteCell:Переместить ячейки"
	"moxelDupName:Конфликт имен"
	"moxelFind:Поиск"
	"moxelGoToCell"
	"MoxelHeadersAndFooters"
	"moxelInsert"
	"moxelLWSEdit"
	"moxelName:Имя"
	"moxelNames:Имена"
	"moxelProperties"
	"moxelReplace"
	"moxelRowHeight"
	"moxelSave:Сохранить"
	"moxelSectionName"
	"moxelSectType:Новая группа"
	"moxelSplitCell:Разбить ячейки"
	"NotificationsDlgNew:Оповещения"
	"ObjectBlocking"
	"ObjectBlockingMessage:Отправить сообщение"
	"ObjectChangedOrDeleted:Данные были изменены"
	"OpenValueDlg"
	"PageSettings"
	"PerfSettings:Настройка показателей производительности"
	"PerfStats:Вызовы сервера - история накопленных"
	"PeriodList:Выберите период"
	"pictureChoose:Выбор картинки"
	"pictureView"
	"planneritemedit"
	"planneritemschedule:Редактирование расписания"
	"PostingMode:Выбор режима проведения"
	"ReportSettingsStorageLoadForm:Выбор настроек отчета"
	"ReportSettingsStorageSaveForm:Сохранение настроек отчета"
	"ReportVariantsStorageLoadForm:Выбор варианта отчета"
	"ReportVariantsStorageSaveForm:Сохранение варианта отчета"
	"SearchForm:Поиск"
	"SelectFileDlg"
	"SelectSymbol:Выбор символа"
	"TaskExecution:Выполнение заданий"
	"UniversalListOutput:Вывести список"
	"UniversalListSettingsStorageLoadForm:Выбор настроек динамического списка"
	"UniversalListSettingsStorageSaveForm:Сохранение настроек динамического списка"
	"WindowsDlg:Все окна";

	
КонецФункции

#КонецОбласти

#КонецЕсли
