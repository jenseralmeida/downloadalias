Imports Microsoft.VisualBasic
Imports System.Configuration




Public Class DownloadAliasSectionHandler
    Inherits NameValueSectionHandler

    Protected Overrides ReadOnly Property KeyAttributeName() As String
        Get
            Return "urlAlias"
        End Get
    End Property

    Protected Overrides ReadOnly Property ValueAttributeName() As String
        Get
            Return "redirectUrl"
        End Get
    End Property


End Class
