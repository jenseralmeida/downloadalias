Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.IO


Public Class DownloadAliasHandler
    Implements IHttpHandler

    Public ReadOnly Property IsReusable() As Boolean Implements System.Web.IHttpHandler.IsReusable
        Get
            Return True
        End Get
    End Property

    Public Sub ProcessRequest(ByVal context As System.Web.HttpContext) Implements System.Web.IHttpHandler.ProcessRequest
        'Get the expected redirect url if exists a alias configured
        Dim ConfiguredAlias As NameValueCollection = ConfigurationManager.GetSection("DownloadAlias")
        Dim UrlRedirect As String = ""
        Dim UrlConfiguredAsAlias As Boolean
        Dim RawUrl As String = context.Request.RawUrl
        For Each UrlAlias As String In ConfiguredAlias.Keys
            UrlRedirect = ConfiguredAlias(UrlAlias)
            UrlAlias = VirtualPathUtility.ToAbsolute(UrlAlias)
            If UrlAlias.Equals(RawUrl) Then
                UrlConfiguredAsAlias = True
                UrlRedirect = VirtualPathUtility.ToAbsolute(UrlRedirect)
                Exit For
            Else
                UrlConfiguredAsAlias = False
            End If
        Next

        'If the url is defined as a alias execute the redirect
        If UrlConfiguredAsAlias Then
            ' The physical path is the redirected url configured in the web.config for the alias requested
            Dim PhysicalPath As String = context.Server.MapPath(UrlRedirect)
            DownloadFile(context, PhysicalPath)
        Else
            ' The physical path is the requested url
            Dim PhysicalPath As String = context.Request.PhysicalPath
            DownloadFile(context, PhysicalPath)
        End If

    End Sub

    Private Sub DownloadFile(ByVal context As System.Web.HttpContext, ByVal PhysicalPath As String)
        Dim StatusCode As Integer = 0

        Try
            Dim TheFileRequestedExists As Boolean = File.Exists(PhysicalPath)
            If TheFileRequestedExists Then
                Dim FileName As String = Path.GetFileName(PhysicalPath)
                context.Response.Clear()
                context.Response.AddHeader("Content-Disposition", "attachment; filename=" + FileName)
                context.Response.ContentType = "application/exe"
                context.Response.TransmitFile(PhysicalPath)
                context.Response.End()
            Else
                StatusCode = 404
            End If
        Catch ex As UnauthorizedAccessException
            StatusCode = 403
        Catch ex As FileNotFoundException
            StatusCode = 404
        End Try
        ' Setting the status code when something wrong 
        If StatusCode > 0 Then
            context.Response.StatusCode = StatusCode
            Throw New HttpException(StatusCode, StatusCode.ToString())
        End If
    End Sub
End Class
