
// Заполняет описания поставляемых профилей групп доступа и
// переопределяет параметры обновления профилей и групп доступа.
//
// Для автоматической подготовки содержимого процедуры следует воспользоваться инструментами
// разработчика для подсистемы Управление доступом.
//
// Параметры:
//  ОписанияПрофилей - Массив из см. УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа,
//                               см. УправлениеДоступом.НовоеОписаниеПапкиПрофилейГруппДоступа
//  ПараметрыОбновления - Структура:
//   * ОбновлятьИзмененныеПрофили - Булево - начальное значение Истина.
//   * ЗапретитьИзменениеПрофилей - Булево - начальное значение Истина.
//       Если установить Ложь, тогда поставляемые профили можно не только просматривать, но и редактировать.
//   * ОбновлятьГруппыДоступа     - Булево - начальное значение Истина.
//   * ОбновлятьГруппыДоступаСУстаревшимиНастройками - Булево - начальное значение Ложь.
//       Если установить Истина, то настройки значений, выполненные администратором для
//       вида доступа, который был удален из профиля, будут также удалены из групп доступа.
//
// Пример:
//  ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
//  ОписаниеПрофиля.Имя           = "Менеджер";
//  ОписаниеПрофиля.Идентификатор = "75fa0ecb-98aa-11df-b54f-e0cb4ed5f655";
//  ОписаниеПрофиля.Наименование  = НСтр("ru = 'Менеджер по продажам'", ОбщегоНазначения.КодОсновногоЯзыка());
//  ОписаниеПрофиля.Роли.Добавить("ЗапускВебКлиента");
//  ОписаниеПрофиля.Роли.Добавить("ЗапускТонкогоКлиента");
//  ОписаниеПрофиля.Роли.Добавить("БазовыеПраваБСП");
//  ОписаниеПрофиля.Роли.Добавить("Подсистема_Продажи");
//  ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеДокументовПокупателей");
//  ОписаниеПрофиля.Роли.Добавить("ПросмотрОтчетаКнигаПокупок");
//  ОписанияПрофилей.Добавить(ОписаниеПрофиля);
//
//  ОписаниеПапки = УправлениеДоступом.НовоеОписаниеПапкиПрофилейГруппДоступа();
//  ОписаниеПапки.Имя           = "ДополнительныеПрофили";
//  ОписаниеПапки.Идентификатор = "69a066e7-ce81-11eb-881c-b06ebfbf08c7";
//  ОписаниеПапки.Наименование  = НСтр("ru = 'Дополнительные профили'", ОбщегоНазначения.КодОсновногоЯзыка());
//  ОписанияПрофилей.Добавить(ОписаниеПапки);
//
//  ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
//  ОписаниеПрофиля.Родитель = "ДополнительныеПрофили";
//  ОписаниеПрофиля.Идентификатор = "70179f20-2315-11e6-9bff-d850e648b60c";
//  ОписаниеПрофиля.Наименование = НСтр("ru = 'Редактирование, отправка по почте, сохранение в файл печатных форм (дополнительно)'",
//  	ОбщегоНазначения.КодОсновногоЯзыка());
//  ОписаниеПрофиля.Описание = НСтр("ru = 'Дополнительно назначается пользователям, которым должна быть доступна возможность редактирования,
//  	|перед печатью, отправка по почте и сохранение в файл сформированных печатных форм.'");
//  ОписаниеПрофиля.Роли.Добавить("РедактированиеПечатныхФорм");
//  ОписанияПрофилей.Добавить(ОписаниеПрофиля);
//
Процедура ПриЗаполненииПоставляемыхПрофилейГруппДоступа(ОписанияПрофилей, ПараметрыОбновления) Экспорт
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "Менеджер по продажам";
	ОписаниеПрофиля.Идентификатор = "21c30ab2-3d82-4f54-be4c-d303b5f826ea";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Менеджер по продажам'", ОбщегоНазначения.КодОсновногоЯзыка());
	ОписаниеПрофиля.Роли.Добавить("ЗапускВебКлиента");
	ОписаниеПрофиля.Роли.Добавить("ЗапускТонкогоКлиента");
	ОписаниеПрофиля.Роли.Добавить("БазовыеПраваБСП");
	ОписаниеПрофиля.Роли.Добавить("ВыводНаПринтерФайлБуферОбмена");
	ОписаниеПрофиля.Роли.Добавить("ПросмотрСвязанныеДокументы");
	ОписаниеПрофиля.Роли.Добавить("СохранениеДанныхПользователя");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеВариантовОтчетов");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеДополнительныхОтчетовИОбработок");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеДополнительныхСведений");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеУчетныхЗаписейЭлектроннойПочты");
	ОписаниеПрофиля.Роли.Добавить("БазоваяФункциональностьТП");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеКонтрагентов");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеДокументовПродажи");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеВзаиморасчетовСПокупателями");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеНСИ");
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "Менеджер по закупкам";
	ОписаниеПрофиля.Идентификатор = "0ab577d8-fbac-45a9-b44f-7a0ca3c96d2c";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Менеджер по закупкам'", ОбщегоНазначения.КодОсновногоЯзыка());
	ОписаниеПрофиля.Роли.Добавить("ЗапускВебКлиента");
	ОписаниеПрофиля.Роли.Добавить("ЗапускТонкогоКлиента");
	ОписаниеПрофиля.Роли.Добавить("БазовыеПраваБСП");
	ОписаниеПрофиля.Роли.Добавить("ВыводНаПринтерФайлБуферОбмена");
	ОписаниеПрофиля.Роли.Добавить("ПросмотрСвязанныеДокументы");
	ОписаниеПрофиля.Роли.Добавить("СохранениеДанныхПользователя");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеВариантовОтчетов");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеДополнительныхОтчетовИОбработок");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеДополнительныхСведений");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеУчетныхЗаписейЭлектроннойПочты");
	ОписаниеПрофиля.Роли.Добавить("БазоваяФункциональностьТП");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеКонтрагентов");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеДокументовПокупки");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеВзаиморасчетовСПоставщиками");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеНСИ");
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "Главный бухгалтер";
	ОписаниеПрофиля.Идентификатор = "0f2150dc-9fcd-4dcd-a1be-e5fe363efa73";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Главный бухгалтер'", ОбщегоНазначения.КодОсновногоЯзыка());
	ОписаниеПрофиля.Роли.Добавить("ЗапускВебКлиента");
	ОписаниеПрофиля.Роли.Добавить("ЗапускТонкогоКлиента");
	ОписаниеПрофиля.Роли.Добавить("БазовыеПраваБСП");
	ОписаниеПрофиля.Роли.Добавить("ВыводНаПринтерФайлБуферОбмена");
	ОписаниеПрофиля.Роли.Добавить("ПросмотрСвязанныеДокументы");
	ОписаниеПрофиля.Роли.Добавить("СохранениеДанныхПользователя");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеВариантовОтчетов");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеДополнительныхОтчетовИОбработок");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеДополнительныхСведений");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеУчетныхЗаписейЭлектроннойПочты");
	ОписаниеПрофиля.Роли.Добавить("БазоваяФункциональностьТП");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеКонтрагентов");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеДокументовПокупки");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеДокументовПродажи");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеНСИ");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзмененияДенежныхДокументов");
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
	
	
	//Начало вставки: Задача: ONEC-MID-DIPLOM. Автор: Николаенков В.А. Дата: 13.08.2024
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "Менеджер";
	ОписаниеПрофиля.Идентификатор = "0f2150dc-9fcd-4dcd-a1be-e5fe363efa74";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Менеджер'", ОбщегоНазначения.КодОсновногоЯзыка());
	ОписаниеПрофиля.Роли.Добавить("ЗапускВебКлиента");
	ОписаниеПрофиля.Роли.Добавить("ЗапускТонкогоКлиента");
	ОписаниеПрофиля.Роли.Добавить("БазовыеПраваБСП");
	ОписаниеПрофиля.Роли.Добавить("ВыводНаПринтерФайлБуферОбмена");
	ОписаниеПрофиля.Роли.Добавить("ПросмотрСвязанныеДокументы");
	ОписаниеПрофиля.Роли.Добавить("СохранениеДанныхПользователя");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеВариантовОтчетов");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеДополнительныхОтчетовИОбработок");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеДополнительныхСведений");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеУчетныхЗаписейЭлектроннойПочты");
	ОписаниеПрофиля.Роли.Добавить("БазоваяФункциональностьТП");
	ОписаниеПрофиля.Роли.Добавить("ВКМ_ПодсистемаДобавленныеОбъекты");
	ОписаниеПрофиля.Роли.Добавить("ВКМ_ПодсистемаРаботаСЗаявкамиКлиентов");
	ОписаниеПрофиля.Роли.Добавить("ВКМ_ДобавлениеИзменениеОбслуживаниеКлиента");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеНСИ");
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);


    ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "Специалист";
	ОписаниеПрофиля.Идентификатор = "0f2150dc-9fcd-4dcd-a1be-e5fe363efa75";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Специалист'", ОбщегоНазначения.КодОсновногоЯзыка());
	ОписаниеПрофиля.Роли.Добавить("ЗапускВебКлиента");
	ОписаниеПрофиля.Роли.Добавить("ЗапускТонкогоКлиента");
	ОписаниеПрофиля.Роли.Добавить("БазовыеПраваБСП");
	ОписаниеПрофиля.Роли.Добавить("ВыводНаПринтерФайлБуферОбмена");
	ОписаниеПрофиля.Роли.Добавить("ПросмотрСвязанныеДокументы");
	ОписаниеПрофиля.Роли.Добавить("СохранениеДанныхПользователя");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеВариантовОтчетов");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеДополнительныхОтчетовИОбработок");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеДополнительныхСведений");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеУчетныхЗаписейЭлектроннойПочты");
	ОписаниеПрофиля.Роли.Добавить("БазоваяФункциональностьТП");
	ОписаниеПрофиля.Роли.Добавить("ВКМ_ПодсистемаДобавленныеОбъекты");
	ОписаниеПрофиля.Роли.Добавить("ВКМ_ПодсистемаРаботаСЗаявкамиКлиентов");
	ОписаниеПрофиля.Роли.Добавить("ВКМ_ДобавлениеИзменениеОбслуживаниеКлиента");
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
	
	ОписаниеПрофиля = УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа();
	ОписаниеПрофиля.Имя           = "БухгалтерИТФирмы";
	ОписаниеПрофиля.Идентификатор = "0f2150dc-9fcd-4dcd-a1be-e5fe363efa76";
	ОписаниеПрофиля.Наименование  = НСтр("ru = 'Бухгалтер ИТ фирмы'", ОбщегоНазначения.КодОсновногоЯзыка());
	ОписаниеПрофиля.Роли.Добавить("ЗапускВебКлиента");
	ОписаниеПрофиля.Роли.Добавить("ЗапускТонкогоКлиента");
	ОписаниеПрофиля.Роли.Добавить("БазовыеПраваБСП");
	ОписаниеПрофиля.Роли.Добавить("ВыводНаПринтерФайлБуферОбмена");
	ОписаниеПрофиля.Роли.Добавить("ПросмотрСвязанныеДокументы");
	ОписаниеПрофиля.Роли.Добавить("СохранениеДанныхПользователя");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеВариантовОтчетов");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеДополнительныхОтчетовИОбработок");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеДополнительныхСведений");
	ОписаниеПрофиля.Роли.Добавить("ЧтениеУчетныхЗаписейЭлектроннойПочты");
	ОписаниеПрофиля.Роли.Добавить("БазоваяФункциональностьТП");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеКонтрагентов");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеДокументовПокупки");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеДокументовПродажи");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзменениеНСИ");
	ОписаниеПрофиля.Роли.Добавить("ДобавлениеИзмененияДенежныхДокументов");
	ОписаниеПрофиля.Роли.Добавить("ВКМ_ПодсистемаДобавленныеОбъекты");
	ОписаниеПрофиля.Роли.Добавить("ВКМ_ПодсистемаРаботаСЗаявкамиКлиентов");
	ОписаниеПрофиля.Роли.Добавить("ВКМ_ЧтениеОбслуживаниеКлиента");
    ОписаниеПрофиля.Роли.Добавить("ВКМ_ИспользованиеОбработкиМассовоеСозданиеАктов");
	ОписанияПрофилей.Добавить(ОписаниеПрофиля);
//Конец вставки

КонецПроцедуры
