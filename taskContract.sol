// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.7;

// contract TaskContract {

//     int numero = 150;

//     function VewNumber () public view returns (int) {
//         return numero;
//     }

// }

contract TaskContractTwo {

    uint nextId; // En una variable de número entero positivo sin asignar un valor, por defecto almacena un 0

    struct Task {
        uint id;
        string name;
        string description;
    }

    Task[] tasks; // Vuelvo a declarar la estructura para ponerle un nombre ( tasks )

    function createTask (string memory _name, string memory _description) public {
        tasks.push(Task(nextId, _name, _description));
        nextId++;
    }

    // Creo una función para hacer una búsqueda de si existe el índice que quiero o no:

    function findIndex (uint _id) internal view returns (uint) { // especificamos que es una función interna ( no se ve desde fuera ) con ( internal )
        for (uint i = 0; i < tasks.length; i++) {
            if (tasks[i].id == _id) {
                return i;
            }
        }
        revert("Error, task not found");
    }

    // En una blockchain en realidad no podemos ver todo el valor de una lista, lo que podemos hacer
    // es consultar una por una.
    // Para esto tenemos que crear otra función:

    function readTask(uint _id) public view returns (uint, string memory, string memory) {
        // A los parámetros tenemos que añadirle un underline " _nombre " para identificarlo como tal,
        // también especificar siempre el tipo de dato
        uint index = findIndex(_id);

        return (tasks[index].id, tasks[index].name, tasks[index].description);
    }

    function updateTasks (uint _id, string memory _name, string memory _description) public {
        uint index = findIndex(_id);
        tasks[index].name = _name;
        tasks[index].description = _description;
    }

    function deleteTask (uint _id) public {
        uint index = findIndex(_id);
        delete tasks[index];
    }
}