<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Download Alias</title>
</head>
<body>
    <form id="form1" runat="server">
        <h1>
            DOWNLOAD ALIAS</h1>
        This solution create a infrastructure to create alias for downloads. It is simple,
        short and elegant.
        It does not implements nothing in the client-side. So only the normal warning when you do a download of a .exe is showed.
        <div>
            <h2>
                There is 3 main points in this solution</h2>
            <h3>
                Create a custom HttpHandler for add suport to alias for downloads</h3>
            <div style="padding-left: 50px">
                -&gt; File DownloadAliasHandler.vb in the HttpHandlers folder<br />
                -&gt; The DownloadAliasHandler verify if exists some alias configured for the requested
                file, if does not exists then verify if the requested file exists.<br />
                -&gt; If the file does not exists then set the HTTP status for 404</div>
            <h3>
                Install the handler in the ASP.NET site</h3>
            <div style="padding-left: 50px">
                -&gt; Add the section below in the web.config file, look for the web.config in this
                project for more details&nbsp;<br />
                <div style="padding-left: 50px">
                    <pre style="width: 750px; height: 50px;">&lt;httpHandlers&gt;
    &lt;add verb="*" path="*.exe" type="DownloadAliasHandler"/&gt;
&lt;/httpHandlers&gt;</pre>
                </div>
                <br />
                -&gt; If you are working with ASP.NET WebSite projetct then the http handler must
                be a fully qualified assembly name .
                <div style="padding-left: 50px">
                    <pre style="width: 750px; height: 50px">&lt;httpHandlers&gt;
    &lt;add verb="*" path="*.exe" type="Namespace.DownloadAliasHandler, AssemblyName"/&gt;
&lt;/httpHandlers&gt;</pre>
                </div>
            </div>
            <h3>
                Config the alias in the web.config file</h3>
            <div style="padding-left: 50px">
                -&gt; Add the section below in the web.config file, look for the web.config in this
                project for more details&nbsp;<br />
                <div style="padding-left: 50px">
                    <pre style="width: 750px; height: 50px;">&lt;configSections&gt;
    &lt;section name ="DownloadAlias" type="DownloadAliasSectionHandler"/&gt;
&lt;/configSections&gt;</pre>
                </div>
                -&gt; If you are working with ASP.NET WebSite projetct then the ConfigSection must
                be a fully qualified assembly name.
                <br />
                <br />
                -&gt; Now configure all the alias did you want in the web.config file<br />
                <div style="padding-left: 50px">
                    <pre style="width: 750px; height: 65px;">&lt;DownloadAlias&gt;
    &lt;add urlAlias="~/Download/123.exe" redirectUrl="~/Download/abc.exe"/&gt;
    &lt;add urlAlias="~/xyzAlias.exe" redirectUrl="~/Download/xyz.exe"/&gt;
&lt;/DownloadAlias&gt;</pre>
                </div>
                <br />
                -&gt; Thats all... if you need some more alias, all you need to do is add some more
                rows in the &lt;DownloadAlias&gt; config section of the web.config.</div>
        </div>
        <br />
        <h2>
            Examples</h2>
        <div>
            <table>
                <tr>
                    <td>
                        Original file:
                    </td>
                    <td>
                        <a href="Download/abc.exe">Download/abc.exe</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        Alias file:</td>
                    <td>
                        <a href="Download/123.exe">Download/123.exe</a></td>
                </tr>
                <tr>
                    <td>
                    Alias file, but another path:</td>
                    <td>
                    <a href="123.exe">123.exe</a></td>
                </tr>
                <tr>
                    <td>
                        Another file:
                    </td>
                    <td>
                    <a href="Download/xyz.exe">Download/xyz.exe</a></td>
                </tr>
                <tr>
                    <td>
                        Another alias file:
                    </td>
                    <td>
                    <a href="xyzAlias.exe">xyzAlias.exe</a></td>
                </tr>
                <tr>
                    <td>
                    One more file: 
                    </td>
                    <td>
                    <a href="khy.exe">khy.exe</a></td>
                </tr>
                <tr>
                    <td style="height: 21px">
                    HTTP 404 (file does not exists in this path):</td>
                    <td style="height: 21px">
                        <a href="Download/khy.exe">Download/khy.exe</a></td>
                </tr>
                <tr>
                    <td style="height: 21px">
                        HTTP 404 (file does not exists at all):</td>
                    <td style="height: 21px">
                        <a href="Download/qwe.exe">Download/qwe.exe</a></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
