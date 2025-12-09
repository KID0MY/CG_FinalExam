using System;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Movement : MonoBehaviour
{
    private int PelletCount;
    private int PacLifes = 3;
    public TMP_Text PacLife;
    public float speed = 5f; // Movement speed
    public GameObject player;
    void Update()
    {
        // Get input values
        float horizontal = Input.GetAxis("Horizontal"); // A/D or Left/Right
        float vertical = Input.GetAxis("Vertical");     // W/S or Up/Down
        // Movement direction
        Vector3 direction = new Vector3(horizontal, 0f, vertical);

        // Apply movement
        transform.Translate(direction * speed * Time.deltaTime);
        
        if (PelletCount >= 7 || Input.GetKeyDown(KeyCode.Escape))
        {
            Application.Quit();
        }
        PacLife.text = "Lifes Left " +PacLifes.ToString();
        
    }

    private void OnCollisionEnter(UnityEngine.Collision other)
    {
        if (other.gameObject.CompareTag("Pellet")) 
        { 
            Destroy(other.gameObject);
            PelletCount++;
        }
        if (other.gameObject.CompareTag("Enemy"))
        {
            if (PacLifes <= 0)
            {
                SceneManager.LoadScene(SceneManager.GetActiveScene().name);
            }
            else
            {
                PacLifes--;
                gameObject.transform.position = new Vector3(0,2,0);
            }
        }
    }
}
