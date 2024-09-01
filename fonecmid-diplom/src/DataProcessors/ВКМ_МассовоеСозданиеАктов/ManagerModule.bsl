Функция ЗаполнитьНаСервере(ДатаНачала, ДатаОкончания) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	РеализацияТоваровУслуг.Ссылка КАК Ссылка,
	|	РеализацияТоваровУслуг.Дата
	|ПОМЕСТИТЬ ВТ_Реализации
	|ИЗ
	|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
	|ГДЕ
	|	РеализацияТоваровУслуг.Дата МЕЖДУ &ДатаНачала И &ДатаОкончания
	|	И НЕ РеализацияТоваровУслуг.ПометкаУдаления
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДоговорыКонтрагентов.Ссылка КАК Договор,
	|	ВТ_Реализации.Ссылка КАК Реализация
	|ИЗ
	|	ВТ_Реализации КАК ВТ_Реализации
	|		ПРАВОЕ СОЕДИНЕНИЕ Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
	|		ПО (ДоговорыКонтрагентов.Ссылка = ВТ_Реализации.Ссылка.Договор)
	|ГДЕ
	|	ДоговорыКонтрагентов.ВидДоговора = &ВидДоговора
	|	И ДоговорыКонтрагентов.ВКМ_ДатаОкончанияДействияДоговора >= &ДатаОкончания
	//Начало вставки: Задача: ONEC-MID-DIPLOM. Автор: Николаенков В.А. Дата: 01.09.2024
	|	И ДоговорыКонтрагентов.ДоговорыКонтрагентов.ВКМ_ДатаНачалаДействияДоговора <= ВТ_Реализации.Дата";
	//Конец вставки
	
	
	Запрос.УстановитьПараметр("ВидДоговора", Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание);
	Запрос.УстановитьПараметр("ДатаНачала", ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания", ДатаОкончания);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	СписокРеализацийМассив = Новый Массив;
	
	Пока Выборка.Следующий() Цикл
		
		СписокРеализацийСтруктура = Новый Структура;
		
		Если НЕ ЗначениеЗаполнено(Выборка.Реализация) Тогда
			НоваяРеализация = СоздатьНовыйРеализация(Выборка.Договор, ДатаОкончания);
			СписокРеализацийСтруктура.Вставить("Договор", Выборка.Договор);
			СписокРеализацийСтруктура.Вставить("Реализация", НоваяРеализация);
			
		Иначе
			СписокРеализацийСтруктура.Вставить("Договор", Выборка.Договор);
			СписокРеализацийСтруктура.Вставить("Реализация", Выборка.Реализация);
			
		КонецЕсли;
		
		СписокРеализацийМассив.Добавить(СписокРеализацийСтруктура);
		
	КонецЦикла;
	
	Возврат СписокРеализацийМассив;
	
КонецФункции

функция СоздатьНовыйРеализация(Договор, ДатаСозданияНовойРеализации)
	
	НоваяРеализация = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
	НоваяРеализация.ВКМ_ВыполнитьАвтозаполнение(Договор, ДатаСозданияНовойРеализации);
	НоваяРеализация.Дата = ДатаСозданияНовойРеализации;
	НоваяРеализация.Договор = Договор;
	НоваяРеализация.Контрагент = Договор.Владелец;
	НоваяРеализация.Организация = Договор.Организация;
	//Начало вставки: Задача: ONEC-MID-DIPLOM. Автор: Николаенков В.А. Дата: 01.09.2024
	#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
    НоваяРеализация.Ответственный = Пользователи.ТекущийПользователь();
    #КонецЕсли
	//Конец вставки
	НоваяРеализация.Записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Неоперативный);
	
	//Начало вставки: Задача: ONEC-MID-DIPLOM. Автор: Николаенков В.А. Дата: 01.09.2024
	Если ЗначениеЗаполнено(НоваяРеализация.СуммаДокумента) и
	     ЗначениеЗаполнено(НоваяРеализация.Контрагент) и
	     ЗначениеЗаполнено(НоваяРеализация.Договор)
	 тогда
	//Конец вставки 	
	НоваяРеализация.Записать(РежимЗаписиДокумента.Проведение, РежимПроведенияДокумента.Неоперативный);
	
	Возврат НоваяРеализация.Ссылка;
	//Начало вставки: Задача: ONEC-MID-DIPLOM. Автор: Николаенков В.А. Дата: 01.09.2024
    иначе
	Отказ = Истина;    
	Сообщить("Нет данных по услугам для заполнения для " + НоваяРеализация.Ссылка);
	//Конец вставки 
	КонецЕсли;
	
КонецФункции
