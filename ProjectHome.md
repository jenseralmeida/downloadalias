# There is 3 main points in this solution #
## Create a custom HttpHandler for add suport to alias for downloads ##
  * File DownloadAliasHandler.vb in the HttpHandlers folder
  * The DownloadAliasHandler verify if exists some alias configured for the requested file, if does not exists then verify if the requested file exists.
  * If the file does not exists then set the HTTP status for 404
## Install the handler in the ASP.NET site ##
  * Add the section below in the web.config file, look for the web.config in this project for more details

```
<httpHandlers>
    <add verb="*" path="*.exe" type="DownloadAliasHandler"/>
</httpHandlers>
```

  * If you are working with ASP.NET WebSite projetct then the http handler must be a fully qualified assembly name .

```
<httpHandlers>
    <add verb="*" path="*.exe" type="Namespace.DownloadAliasHandler, AssemblyName"/>
</httpHandlers>Config the alias in the web.config file
```

## Add the section below in the web.config file, look for the web.config in this project for more details ##

```
<configSections>
    <section name ="DownloadAlias" type="DownloadAliasSectionHandler"/>
</configSections>
```

  * If you are working with ASP.NET WebSite projetct then the ConfigSection must be a fully qualified assembly name.

  * Now configure all the alias did you want in the web.config file

```
<DownloadAlias>
    <add urlAlias="~/Download/123.exe" redirectUrl="~/Download/abc.exe"/>
    <add urlAlias="~/xyzAlias.exe" redirectUrl="~/Download/xyz.exe"/>
</DownloadAlias>
```

Thats all... if you need some more alias, all you need to do is add some more rows in the 

&lt;DownloadAlias&gt;

 config section of the web.config.