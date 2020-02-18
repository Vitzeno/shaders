using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class CustomImageEffect : MonoBehaviour
{
    public Material effectMaterial;
    public float _Offset = 0.001f;
    public float _Threshold = 0.1f;
    public float _Thickness = 1.0f;
    public Color _Colour = Color.black;

    void Awake ()
    {
        effectMaterial = new Material(Shader.Find("Custom/Edge Detection") );
    }

    void OnRenderImage(RenderTexture src, RenderTexture dst) 
    {
        Graphics.Blit(src, null, effectMaterial);
        effectMaterial.SetFloat("_Offset", _Offset);
        effectMaterial.SetFloat("_Threshold", _Threshold);
        effectMaterial.SetFloat("_Thickness", _Thickness);
        effectMaterial.SetColor("_Colour", _Colour);
    }
}
