Перем СТаблицамиБезБСП Экспорт;
Перем БезТаблицБезБСП Экспорт;
Перем СТаблицамиСБСП Экспорт;
Перем БезТаблицСБСП Экспорт;
Перем Портативный Экспорт;

Функция НовыйВариантСборки(Имя, ИмяФайла, СуффиксИмени, СуффиксСинонима,ИсключатьТаблицыБД, ПоддержкаБСП)
	Вариант = Новый Структура;
	Вариант.Вставить("Имя", Имя);
	Вариант.Вставить("ИмяФайла", ИмяФайла);
	Вариант.Вставить("ПоддержкаБСП", ПоддержкаБСП);
	Вариант.Вставить("ИсключатьТаблицыБД", ИсключатьТаблицыБД);
	Вариант.Вставить("СуффиксИмени", СуффиксИмени);
	Вариант.Вставить("СуффиксСинонима", СуффиксСинонима);
	
	Возврат Вариант;
КонецФункции

СТаблицамиСБСП = НовыйВариантСборки("Полный", "UI", "", "", Ложь, Истина);
БезТаблицБезБСП = НовыйВариантСборки("Минимальный", "UI_nossl_only_dataprocessor_8_3_10", "БезТаблицБезБСП", "/Без изменения таблиц базы данных/Без поддержки БСП/Режим совместимости 8.3.10", Истина, Ложь);

СТаблицамиБезБСП = НовыйВариантСборки("БезПоддержкиБСП", "UI_nossl", "БезБСП", "без поддержки БСП", Ложь, Ложь);
БезТаблицСБСП = НовыйВариантСборки("БезИзмененияТаблиц", "UI_ssl_only_dataprocessor_8_3_10", "БСПБезТаблиц", "/Без изменения таблиц базы данных/Поддержка БСП/Режим совместимости 8.3.10", Истина, Истина);

Портативный = НовыйВариантСборки("Портативный", "UI_Portable", "", "", Ложь, Ложь);
