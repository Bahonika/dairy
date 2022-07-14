# dairy

Папки:
    entities - содержит папки со всеми необходимыми сущностями.
        abstract - содержит абстрактные сущности, в них прописаны основы взаимодействия с api.
        get_entities - сущности, которые в дальнейшем необходимо будет отобразить. Сущности, которые мы получаем с сервера.
        get_repositories - репозитории для получения данных.
        post_entities - сущности, которые в дальнейшем необходимо будет отправить на сервер.
        post_repositories - репозитории для отправки, изменения и удаления данных.
    providers - все провайдеры, необходимые для StateManagement приложения. То что управляет состоянием.
    screens - все экраны с ui и виджеты для отображения.
Файлы:
    main - место запуска приложения.
    utf_8_converter - функция для конвертирования данных после получения с сервера.
    main_menu_button - кнопки на главном экране.