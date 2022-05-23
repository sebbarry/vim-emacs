

function Function(value) {


    this.init = function() {
        this.value = value;
    }
    this.printValue = function() {
        console.log(this.value);
    }



    this.init();

}


let value = new Function(4);
value.printValue();



function thisFunction(){
    var value = true;
    this.a = function() {
        return true;
    }
    this.a()
}




function *gen() {
    return {"next": true}
}

while(gen().next == true) 
{
    gen()
}

function thisFunc() {
    return true;
}
