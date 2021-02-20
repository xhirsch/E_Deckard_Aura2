using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowObject : MonoBehaviour
{

    public GameObject Master;
    public bool KeepOffset = true;
    public bool FollowX;
    public bool FollowY;
    public bool FollowZ;

    private Vector3 masterOffset;

    // Start is called before the first frame update
    void Start()
    {
        if (!KeepOffset)
            return;
        masterOffset = Master.transform.position;
    }

    // Update is called once per frame
    void Update()
    {
        //this.gameObject.transform.position = Master.transform.position - masterOffset;

        if (FollowX)
            this.gameObject.transform.localPosition = new Vector3(Master.transform.position.x - masterOffset.x, this.transform.position.y, this.transform.position.z);
        if (FollowY)
            this.gameObject.transform.localPosition = new Vector3(this.transform.position.x, Master.transform.position.y - masterOffset.y, this.transform.position.z);
        if (FollowZ)
            this.gameObject.transform.localPosition = new Vector3(this.transform.position.x, this.transform.position.y, Master.transform.position.z - masterOffset.z);
    }
}
