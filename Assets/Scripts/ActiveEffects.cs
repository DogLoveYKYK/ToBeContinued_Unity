using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ActiveEffects : MonoBehaviour
{
    public GameObject postEffect;

    public void ActiveEffects_(bool isActive)
    {
        foreach(var effect in postEffect.GetComponents<PostEffect>())
        {
            effect.enabled = isActive;
        }
    }

}
