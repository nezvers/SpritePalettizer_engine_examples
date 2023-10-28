using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PaletteSwitch : MonoBehaviour
{
    [SerializeField] int colorCount = 4;
    [SerializeField] float switchInterval = 1f;
    [SerializeField] SpriteRenderer spriteRenderer;

    int index = 0;
    float time;
    Material material;

    private void Start()
    {
        // clone meterial for that instance
        material = Instantiate(spriteRenderer.material);
        spriteRenderer.material = material;
    }

    void Update()
    {
        time += Time.deltaTime;
        if (time < switchInterval) { return; }
        time -= switchInterval * (time / switchInterval);

        index = (index + 1) % colorCount;

        material.SetInteger("_PaletteIndex", index);
    }
}
