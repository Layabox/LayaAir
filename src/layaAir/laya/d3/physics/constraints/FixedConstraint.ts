import { ConstraintComponent } from "./ConstraintComponent";
import { Component } from "../../../components/Component";
import { Physics3D } from "../Physics3D";
import { Scene3D } from "../../core/scene/Scene3D";
import { Sprite3D } from "../../core/Sprite3D";
import { Rigidbody3D } from "../Rigidbody3D";

export class FixedConstraint extends ConstraintComponent{
	/**
	 * 创建一个<code>FixedConstraint</code>实例
	 */
	constructor(){
		super(ConstraintComponent.CONSTRAINT_FIXED_CONSTRAINT_TYPE);
		this.breakForce = -1;
		this.breakTorque = -1;
		
		
	}
	/**
	 * @inheritDoc
	 * @override
	 * @internal
	 */
	_addToSimulation(): void {
		this._simulation && this._simulation.addConstraint(this,this.enabled);
    }
    
     /**
	 * @inheritDoc
	 * @override
	 * @internal
	 */
    _removeFromSimulation():void{
		this._simulation.removeConstraint(this);
		this._simulation = null;
	}

	/**
	 * @inheritDoc
	 * @override
	 * @internal
	 */
	_createConstraint():void{
		var bt = Physics3D._bullet;
		var physicsTransform = bt.btCollisionObject_getWorldTransform(this.ownBody.btColliderObject);
		var origin = bt.btTransform_getOrigin(physicsTransform);
		this._btConstraint = bt.btFixedConstraint_create(this.ownBody.btColliderObject, this._btframAPos, this.connectedBody.btColliderObject, this._btframBPos)
		this._btJointFeedBackObj = bt.btJointFeedback_create(this._btConstraint);	
		bt.btTypedConstraint_setJointFeedback(this._btConstraint,this._btJointFeedBackObj);
		this._simulation = ((<Scene3D>this.owner._scene)).physicsSimulation;
	}

	
	/**
	 * @inheritDoc
	 * @override
	 * @internal
	 */
	_onAdded(): void {
		super._onAdded();
	}
	/**
	 * @inheritDoc
	 * @override
	 * @internal
	 */
	_onEnable():void{
		super._onEnable();
		if(!this._btConstraint){
			if(this.ownBody&&this.ownBody.physicsSimulation&&this.connectedBody&&this.connectedBody.physicsSimulation)
			this._createConstraint();
			this._addToSimulation();
		}
		if(this._btConstraint)
		Physics3D._bullet.btTypedConstraint_setEnabled(this._btConstraint,true);
	}

	_onDisable():void{
		super._onDisable();
		if(!this.connectedBody)
			this._removeFromSimulation();
		if(this._btConstraint)
		Physics3D._bullet.btTypedConstraint_setEnabled(this._btConstraint,false);
	}

	/**
	 * @inheritDoc
	 * @internal
	 * @override
	 */
	protected _onDestroy(): void {
		super._onDestroy();
	}

	/**
	 * @inheritDoc
	 * @internal
	 * @override
	 */
	_parse(data: any,interactMap:any = null): void {
		super._parse(data);
		if(data.rigidbodyID!=-1&&data.connectRigidbodyID!=-1){
			interactMap.component.push(this);
			interactMap.data.push(data);
		}
		(data.breakForce != undefined) && (this.breakForce = data.breakForce);
		(data.breakTorque != undefined) && (this.breakTorque = data.breakTorque);
	}
	/**
	 * @inheritDoc
	 * @internal
	 * @override
	 */
	_parseInteractive(data:any = null,spriteMap:any = null){
		var rigidBodySprite:Sprite3D = spriteMap[data.rigidbodyID];
		var rigidBody: Rigidbody3D = rigidBodySprite.getComponent(Rigidbody3D);
		var connectSprite: Sprite3D = spriteMap[data.connectRigidbodyID];
		var connectRigidbody: Rigidbody3D = connectSprite.getComponent(Rigidbody3D);
		this.ownBody = rigidBody;
		this.connectedBody = connectRigidbody;

	}

	/**
	 * @inheritDoc
	 * @override
	 * @internal
	 */
	_cloneTo(dest: Component): void {
		
	}
}