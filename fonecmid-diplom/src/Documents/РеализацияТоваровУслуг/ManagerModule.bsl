
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Функция ДобавитьКомандуСоздатьНаОсновании(КомандыСозданияНаОсновании) Экспорт
	
	Если ПравоДоступа("Добавление", Метаданные.Документы.РеализацияТоваровУслуг) Тогда
		
        КомандаСоздатьНаОсновании = КомандыСозданияНаОсновании.Добавить();
        КомандаСоздатьНаОсновании.Менеджер = Метаданные.Документы.РеализацияТоваровУслуг.ПолноеИмя();
        КомандаСоздатьНаОсновании.Представление = ОбщегоНазначения.ПредставлениеОбъекта(Метаданные.Документы.РеализацияТоваровУслуг);
        КомандаСоздатьНаОсновании.РежимЗаписи = "Проводить";
		
		Возврат КомандаСоздатьНаОсновании;
		
	КонецЕсли;

	Возврат Неопределено;
	
КонецФункции


//Начало вставки: Задача: ONEC-MID-DIPLOM. Автор: Николаенков В.А. Дата: 04.08.2024
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Идентификатор = "АктОказанныхУслуг";
	КомандаПечати.Представление = НСтр("ru = 'Акт оказанных услуг'");
	КомандаПечати.Порядок = 5;
	
КонецПроцедуры

Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	ПечатнаяФорма = УправлениеПечатью.СведенияОПечатнойФорме(КоллекцияПечатныхФорм, "АктОказанныхУслуг");
	Если ПечатнаяФорма <> Неопределено Тогда
		ПечатнаяФорма.ТабличныйДокумент = АктОказанныхУслуг(МассивОбъектов, ОбъектыПечати);
		ПечатнаяФорма.СинонимМакета = НСтр("ru = 'Акт оказанных услуг'");
		ПечатнаяФорма.ПолныйПутьКМакету = "Документ.РеализацияТоваровУслуг.ВКМ_ПФ_MXL_АктОказанныхУслуг";
	КонецЕсли;
	
КонецПроцедуры

Функция АктОказанныхУслуг(МассивОбъектов, ОбъектыПечати)
	
	ТабличныйДокумент = Новый ТабличныйДокумент;
	ТабличныйДокумент.КлючПараметровПечати = "ПараметрыПечати_АктОказанныхУслуг";
	
	Макет = УправлениеПечатью.МакетПечатнойФормы("Документ.РеализацияТоваровУслуг.ВКМ_ПФ_MXL_АктОказанныхУслуг");
	
	ДанныеДокументов = ПолучитьДанныеДокументов(МассивОбъектов);
	
	ПервыйДокумент = Истина;
	
	Пока ДанныеДокументов.Следующий() Цикл
		
		Если Не ПервыйДокумент Тогда
			
			ТабличныйДокумент.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		
		ПервыйДокумент = Ложь;
		
		ОбластьЗаголовокДокумента = Макет.ПолучитьОбласть("Заголовок");
		
		ДанныеПечати = Новый Структура;
		
		ШаблонЗаголовка = "Акт № %1 от %2";
		ТекстЗаголовка = СтрШаблон(ШаблонЗаголовка,
		ПрефиксацияОбъектовКлиентСервер.НомерНаПечать(ДанныеДокументов.Номер),
		Формат(ДанныеДокументов.Дата, "ДЛФ=DD"));
		ДанныеПечати.Вставить("ТекстЗаголовка", ТекстЗаголовка);
		
		СсыкаНаДокумент = ПолучитьНавигационнуюСсылку(ДанныеДокументов.Ссылка);
		ДанныеQRкода = ГенерацияШтрихкода.ДанныеQRКода(СсыкаНаДокумент, 1, 100);
		КартинкаQRкода = Новый Картинка(ДанныеQRкода);
		
		Если НЕ ТипЗнч(ДанныеQRКода) = Тип("ДвоичныеДанные") Тогда
			ТекстСообщения = НСтр("ru = 'Не удалось сформировать QR-код.
			|Технические подробности см. в журнале регистрации.'");
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		Иначе
			КартинкаQRКода = Новый Картинка(ДанныеQRКода);
			ОбластьЗаголовокДокумента.Рисунки.КурКот.Картинка = КартинкаQRкода;
		КонецЕсли;
		
		ОбластьЗаголовокДокумента.Параметры.Заполнить(ДанныеПечати);
		ТабличныйДокумент.Вывести(ОбластьЗаголовокДокумента);
		
		ОбластьОрганизация = Макет.ПолучитьОбласть("Организация");
		ОбластьКонтрагент = Макет.ПолучитьОбласть("Контрагент");
		ОбластьДоговор = Макет.ПолучитьОбласть("Договор");
		
		ДанныеПечати = Новый Структура;
		ДанныеПечати.Вставить("ПредставлениеОрганизация", ДанныеДокументов.Организация);
		ДанныеПечати.Вставить("ПредставлениеКонтрагента", ДанныеДокументов.Контрагент);
		ДанныеПечати.Вставить("Договор", ДанныеДокументов.Договор);
		
		ОбластьОрганизация.Параметры.Заполнить(ДанныеПечати);
		ТабличныйДокумент.Вывести(ОбластьОрганизация);
		
		ОбластьКонтрагент.Параметры.Заполнить(ДанныеПечати);
		ТабличныйДокумент.Вывести(ОбластьКонтрагент);
		
		ОбластьДоговор.Параметры.Заполнить(ДанныеПечати);
		ТабличныйДокумент.Вывести(ОбластьДоговор);
		
		ОтступНовый = Макет.ПолучитьОбласть("ОтступНовый");
		ТабличныйДокумент.Вывести(ОтступНовый);
		
		ОбластьШапкаТаблицы = Макет.ПолучитьОбласть("ШапкаТаблицы");
		ОбластьСтрока = Макет.ПолучитьОбласть("Строка");
		ТабличныйДокумент.Вывести(ОбластьШапкаТаблицы);
ВыборкаУслуги = ДанныеДокументов.Услуги.Выбрать();
		Пока ВыборкаУслуги.Следующий() Цикл
			ОбластьСтрока.Параметры.Заполнить(ВыборкаУслуги);
			ТабличныйДокумент.Вывести(ОбластьСтрока);
		КонецЦикла;
		
		Отступ = Макет.ПолучитьОбласть("Отступ");
		ТабличныйДокумент.Вывести(Отступ);
		
		ОбластьИтого = Макет.ПолучитьОбласть("Итого");
		ДанныеПечати = Новый Структура;
		ДанныеПечати.Вставить("СуммаДокумента", ДанныеДокументов.СуммаДокумента);
		ОбластьИтого.Параметры.Заполнить(ДанныеПечати);
		ТабличныйДокумент.Вывести(ОбластьИтого);
		
		ОтступВторой = Макет.ПолучитьОбласть("ОтступВторой");
		ТабличныйДокумент.Вывести(ОтступВторой);

		
		ОбластьСуммы = Макет.ПолучитьОбласть("Суммы");
		ДанныеПечати = Новый Структура;
		ДанныеПечати.Вставить("СуммаДокумента", ДанныеДокументов.СуммаДокумента);
		ДанныеПечати.Вставить("СуммаДокументаПропись", 
		ЧислоПрописью(ДанныеДокументов.СуммаДокумента, 
		"Л = ru_RU; ДП = Ложь", "рубль, рубля, рублей, м, копейка, копейки, копеек, ж, 2"));

		ОбластьСуммы.Параметры.Заполнить(ДанныеПечати);
		ТабличныйДокумент.Вывести(ОбластьСуммы);
		
		ОтступТретий = Макет.ПолучитьОбласть("ОтступТретий");
		ТабличныйДокумент.Вывести(ОтступТретий);
		
		
		ОбластьПодвал = Макет.ПолучитьОбласть("Подвал");
		ДанныеПечати = Новый Структура;
		ДанныеПечати.Вставить("ПредставлениеОрганизация", ДанныеДокументов.Организация);
		ДанныеПечати.Вставить("ПредставлениеКонтрагента", ДанныеДокументов.Контрагент);
		
		ОбластьПодвал.Параметры.Заполнить(ДанныеПечати);

		ТабличныйДокумент.Вывести(ОбластьПодвал);
		
		НомерСтрокиНачало = ТабличныйДокумент.ВысотаТаблицы + 1;
		
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(ТабличныйДокумент,
		НомерСтрокиНачало, ОбъектыПечати, ДанныеДокументов.Ссылка);
		
	КонецЦикла;
	
	Возврат ТабличныйДокумент;
	
КонецФункции

Функция ПолучитьДанныеДокументов(МассивОбъектов)
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	РеализацияТоваровУслуг.Ссылка КАК Ссылка,
	               |	РеализацияТоваровУслуг.ВерсияДанных КАК ВерсияДанных,
	               |	РеализацияТоваровУслуг.ПометкаУдаления КАК ПометкаУдаления,
	               |	РеализацияТоваровУслуг.Номер КАК Номер,
	               |	РеализацияТоваровУслуг.Дата КАК Дата,
	               |	РеализацияТоваровУслуг.Проведен КАК Проведен,
	               |	РеализацияТоваровУслуг.Организация КАК Организация,
	               |	РеализацияТоваровУслуг.Контрагент КАК Контрагент,
	               |	РеализацияТоваровУслуг.Договор КАК Договор,
	               |	РеализацияТоваровУслуг.СуммаДокумента КАК СуммаДокумента,
	               |	РеализацияТоваровУслуг.Основание КАК Основание,
	               |	РеализацияТоваровУслуг.Ответственный КАК Ответственный,
	               |	РеализацияТоваровУслуг.Комментарий КАК Комментарий,
	               |	РеализацияТоваровУслуг.Товары.(
	               |		Ссылка КАК Ссылка,
	               |		НомерСтроки КАК НомерСтроки,
	               |		Номенклатура КАК Номенклатура,
	               |		Количество КАК Количество,
	               |		Цена КАК Цена,
	               |		Сумма КАК Сумма
	               |	) КАК Товары,
	               |	РеализацияТоваровУслуг.Услуги.(
	               |		Ссылка КАК Ссылка,
	               |		НомерСтроки КАК НомерСтроки,
	               |		Номенклатура КАК Номенклатура,
	               |		Количество КАК Количество,
	               |		Цена КАК Цена,
	               |		Сумма КАК Сумма
	               |	) КАК Услуги,
	               |	РеализацияТоваровУслуг.Представление КАК Представление,
	               |	РеализацияТоваровУслуг.МоментВремени КАК МоментВремени
	               |ИЗ
	               |	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
	               |ГДЕ
	               |	РеализацияТоваровУслуг.Ссылка В(&МассивОбъектов)";
	
	Запрос.УстановитьПараметр("МассивОбъектов", МассивОбъектов);
	
	Возврат Запрос.Выполнить().Выбрать();
	
КонецФункции
//Конец вставки

#КонецОбласти

#КонецЕсли