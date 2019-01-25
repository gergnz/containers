# A PHP 7.2 Container with oci8 module

Use it as followed:
```
docker run -it -p 8000:8000 -v $PWD:/app gergnz/oci8:php72 /bin/bash
```

Then use your favourite php web server or composer:

```
php artisan serve --host=0.0.0.0 -vvv
```
