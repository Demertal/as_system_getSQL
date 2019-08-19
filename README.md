# as_system_getSQL

## as_system_getSQL_table

На входе принимает код таблицы и overwrite(если 1 то перезапишит все, если 0 то добавит только, то чего небыло). На выходе возвращает строку скрипта, включающего insert для данных о таблице и ее колонках и create для выбранных хранимых процедур для таблицы.

## as_system_getSQL_form

На входе принимает код формы и overwrite(если 1 то перезапишит все, если 0 то добавит только, то чего небыло). На выходе возвращает строку скрипта,
включающего insert для данных о форме и ее полях и create для выбранных хранимых процедур для формы.

## as_system_getSQL_dashboards

На входе принимает код дашборда и overwrite(если 1 то перезапишит все, если 0 то добавит только, то чего небыло). На выходе возвращает строку скрипта,
включающего insert для данных о дашборде и его панелях и create для выбранных хранимых процедур дашборда.

## as_system_getSQL_pages

На входе принимает код страницы и overwrite(если 1 то перезапишит все, если 0 то добавит только, то чего небыло). На выходе возвращает строку скрипта,
включающего insert для данных о стрнице и create для выбранных хранимых процедур дашборда.

## as_system_getSQL_procs

На входе принимает начальный фрагмент названия искомых процедур и overwrite(если 1 то перезапишит все, если 0 то добавит только, то чего небыло). На выходе возвращает строку скрипта,
включающего create для выбранных хранимых процедур.

## as_system_getStringFromCode

На входе принимает код хранимой процедуры. На выходе возвращает строку с кодом хранимой процедуры,
в котором строчные комментарии заменены на блочные.

## split

На входе принимает строку, которую надо разбить, и символ, по которому будет выполняться разбивка.
На выходе вернет построчно разбитую строку.

## Порядок создания процедур

1. split
2. as_system_getStringFromCode
3. as_system_getSQL_procs
4. as_system_getSQL_dashboards, as_system_getSQL_form, as_system_getSQL_table, as_system_getSQL_pages

## Вывод результата в файл

Для вывода результата процедуры в файл нужно:
1. Открыть пункт меню "Запрос"
2. Включить режим "SQLCMD"
3. Прописать перед вызовом процедуры ":OUT d:\filename.txt"

Выполнять по одной процедуре в запросе, иначе результат всех процедур запишется в один файл.
