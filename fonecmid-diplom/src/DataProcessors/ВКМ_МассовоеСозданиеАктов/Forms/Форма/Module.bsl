
#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПериодПриИзменении(Элемент)
	ПериодПриИзмененииНаСервере();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СоздатьАктыРеализацииУслуг(Команда)
	 // 1. Запуск фонового задания на сервере
	ДлительнаяОперация = СоздатьАктыРеализацииУслугНаСервере();
	// 2. Подключение обработчика завершения фонового задания
	ОповещениеОЗавершении = Новый ОписаниеОповещения("ОбработатьРезультат", ЭтотОбъект);
	ОповещениеОПрогрессе = Новый ОписаниеОповещения("ТекущийПрогресс", ЭтотОбъект);
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
	ПараметрыОжидания.ВыводитьПрогрессВыполнения = Истина;
	ПараметрыОжидания.ОповещениеОПрогрессеВыполнения = ОповещениеОПрогрессе;
	
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, ОповещениеОЗавершении, ПараметрыОжидания);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбработатьРезультат(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	ИначеЕсли Результат.Статус = "Ошибка" Тогда
		ВызватьИсключение Результат.КраткоеПредставлениеОшибки;
	КонецЕсли;
	
	ПериодПриИзмененииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ТекущийПрогресс(Прогресс, ДополнительныеПараметры) Экспорт
	
	Если Прогресс.Прогресс <> Неопределено Тогда
		Состояние("Создание актов реализаций...", Прогресс.Прогресс.Процент);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция СоздатьАктыРеализацииУслугНаСервере()
	
	Договоры = Новый Массив;
	
	//Начало вставки: Задача: ONEC-MID-DIPLOM. Автор: Николаенков В.А. Дата: 09.09.2024

	Для Каждого Строка Из Объект.ДанныеОРеализациях Цикл
		Если Строка.РеализацияУслуг = Документы.РеализацияТоваровУслуг.ПустаяСсылка() Тогда
			ЗначенияРеквизитов = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Строка.Договор, "Ссылка, Организация, Владелец");
			Ссылка = ЗначенияРеквизитов.Ссылка;
			Организация = ЗначенияРеквизитов.Организация;
			Контрагент = ЗначенияРеквизитов.Владелец; 
			Договор = Новый Структура;
			Договор.Вставить("Организация", Организация);
			Договор.Вставить("Контрагент", Контрагент);
			Договор.Вставить("Ссылка", Ссылка);
			Договоры.Добавить(Договор);			
		КонецЕсли;
	КонецЦикла;
	//Конец вставки	

	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияПроцедуры();
	Возврат ДлительныеОперации.ВыполнитьПроцедуру(ПараметрыВыполнения,
												"Обработки.ВКМ_МассовоеСозданиеАктов.МассовоеСозданиеРеализацийУслуг",
												Договоры, Объект.Период);
КонецФункции

&НаСервере
Процедура ПериодПриИзмененииНаСервере()
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ДоговорыКонтрагентов.Ссылка КАК Договор
		|ПОМЕСТИТЬ втДоговора
		|ИЗ
		|	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
		|ГДЕ
		|	НЕ ДоговорыКонтрагентов.ПометкаУдаления
		|	И ДоговорыКонтрагентов.ВидДоговора = &ВидДоговора
		|	И ДоговорыКонтрагентов.ВКМ_ДатаОкончанияДействияДоговора >= &ОкончаниеПериода
		|	И ДоговорыКонтрагентов.ВКМ_ДатаНачалаДействияДоговора <= &НачалоПериода
		|
		|ИНДЕКСИРОВАТЬ ПО
		|	Договор
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	втДоговора.Договор КАК Договор,
		|	РеализацияТоваровУслуг.Ссылка КАК РеализацияУслуг
		|ПОМЕСТИТЬ втРеализации
		|ИЗ
		|	втДоговора КАК втДоговора
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
		|		ПО втДоговора.Договор.Ссылка = РеализацияТоваровУслуг.Договор.Ссылка
		|ГДЕ
		|	РеализацияТоваровУслуг.Дата >= &НачалоПериода
		|	И РеализацияТоваровУслуг.Дата <= &ОкончаниеПериода
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	втДоговора.Договор КАК Договор,
		|	втРеализации.РеализацияУслуг КАК РеализацияУслуг
		|ИЗ
		|	втДоговора КАК втДоговора
		|		ЛЕВОЕ СОЕДИНЕНИЕ втРеализации КАК втРеализации
		|		ПО (втДоговора.Договор = втРеализации.Договор)";
	
	Запрос.УстановитьПараметр("ВидДоговора", Перечисления.ВидыДоговоровКонтрагентов.ВКМ_АбонентскоеОбслуживание);
	Запрос.УстановитьПараметр("НачалоПериода", НачалоМесяца(Объект.Период));
	Запрос.УстановитьПараметр("ОкончаниеПериода", КонецМесяца(Объект.Период));
			
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Возврат;
	КонецЕсли;
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Объект.ДанныеОРеализациях.Очистить();
	
	Пока Выборка.Следующий() Цикл
		СтрокаРеализации = Объект.ДанныеОРеализациях.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаРеализации, Выборка);
	КонецЦикла;
КонецПроцедуры

#КонецОбласти