import { Button, Card, Container, Form } from "react-bootstrap";
import React from 'react';
import { database } from 'firebase'
import {GoRadioTower} from 'react-icons/go'
import {GiCrossMark} from 'react-icons/gi'
import DeviceList from "./deviceList";
class Manual extends React.Component {
    constructor(props)
	{
	    super(props);
        this.state={
            img:'/assets/dashboard.svg',
            title:'Manual Search of devices',
            description:'It checks all IOT devices based on IP.',
            showDevices:false,
            min:0,
            max:100
        }
    }
    componentDidMount(){
        const db=database();
        let items=db.ref().child('manual').child('metadata')
        items.on('child_added',(snap)=>{
            const item= snap.val()
            const key= snap.key
            const s={}
            s[key]=item
            if(item)
            this.setState(s);
        })
    }
    addData(){
        const db=database();
        db.ref().child('manual').child('metadata').set({
            img:'/assets/dashboard.svg',
            title:'Manual Search of devices',
            description:'It checks all IOT devices based on IP.',
        })
    }
    render(){
        return <Container>
            <Card style={{boxShadow:'2px 3px 10px grey'}}>
            <Card.Body>
                <center>
                    <Card.Title><h3>{this.state.title}</h3></Card.Title>
                    <Card.Text>
                        <p>{this.state.description}</p>
                    </Card.Text>
                </center>
            </Card.Body>
            <Card.Footer>
                <center>
                    {this.state.showDevices?
                    <Button  onClick={()=>{this.setState({showDevices:false})}} variant='danger' style={{fontSize:'20px',color:'white'}}>
                        <GiCrossMark  style={{marginRight:'10px'}}/>Close
                    </Button>:
                    <div className='flex-container'>
                        Set IP range : 
                        <Form.Group style={{maxWidth:100,margin:'5px'}} onChange={(e)=>{
                            if(e.target.value)
                            this.setState({
                                min:Number(e.target.value),
                            })
                        }} controlId="min">
                            <Form.Control defaultValue={this.state.min} type="number" placeholder="Min" min={0}/>
                        </Form.Group>
                        To
                        <Form.Group style={{maxWidth:100,margin:'5px'}} onChange={(e)=>{
                            if(e.target.value)
                            this.setState({
                                max:Number(e.target.value),
                            })
                        }} controlId="max">
                            <Form.Control defaultValue={this.state.max} type="number" placeholder="Max" min={0}/>
                        </Form.Group>
                        <Button  onClick={()=>{
                            const {max,min}=this.state;
                            if(max>(0-1) && min>(0-1) && max>min)
                            this.setState({showDevices:true,error:undefined})
                            else
                            this.setState({error:"Both Max and Min should be > 0 and positive"})
                            }} variant='warning' style={{fontSize:'20px',margin:'5px'}}>
                            <GoRadioTower style={{marginRight:'10px'}}/>Scan
                        </Button>
                    </div>}<i style={{color:'red'}}>{this.state.error}</i>
                </center>
            </Card.Footer>
            </Card>
            {
                this.state.showDevices && <DeviceList min={this.state.min} max={this.state.max}/>
            }
                {/* <div onClick={()=>{this.addData()}}>Add</div> */}
        </Container>
    }
}
export default Manual;