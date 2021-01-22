#include "Python.h"
#include <wiringPi.h>
#include <wiringPiSPI.h>

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

// description: 

static const int SPI_num = 0;

typedef struct {
  PyObject_HEAD
  // no needed state yet
} SPI;


static void
SPI_dealloc(SPI* self)
{
  // nothing
}

static PyObject *
SPI_new(PyTypeObject *type, PyObject *args, PyObject *kwds)
{
  SPI *self;
  self = (SPI *)type->tp_alloc(type, 0);
  
  return (PyObject *)self;
}

static int
SPI_init(SPI *self, PyObject *args, PyObject *kwds)
{
  // nothing
  return 0;
}

static PyObject *
SPI_sendrecv_byte(SPI* self, PyObject *args)
{
  PyObject *pydata_outgoing;
  if (!PyArg_ParseTuple(args, "O!", &PyString_Type, &pydata_outgoing)){
    return NULL;
  }

  if( PyString_Size(pydata_outgoing) != 1 ){
    fprintf(stderr, "ERROR: sendrecv_byte can only send one byte at a time.\n");
    return PyErr_Occurred();
  }

  uint8_t data = *PyString_AS_STRING(pydata_outgoing);

  if( wiringPiSPIDataRW(SPI_num, &data, sizeof(data)) == -1 ){
    fprintf(stderr, "ERROR: error occurred while sending data.\n");
    return PyErr_Occurred();
  }
  
  PyObject* obj = Py_BuildValue("c", (char)data);

  return obj;
}

static PyMethodDef SPI_methods[] = {
  {"sendrecv_byte", (PyCFunction)SPI_sendrecv_byte, METH_VARARGS,
     "Shifts a single byte to/from the icestick"
  },
  {NULL}  /* Sentinel */
};

static PyTypeObject SPIType = {
  PyObject_HEAD_INIT(NULL)
  0,                         /*ob_size*/
  "RPI_icestick_spi.SPI",    /*tp_name*/
  sizeof(SPI),               /*tp_basicsize*/
  0,                         /*tp_itemsize*/
  (destructor)SPI_dealloc,   /*tp_dealloc*/
  0,                         /*tp_print*/
  0,                         /*tp_getattr*/
  0,                         /*tp_setattr*/
  0,                         /*tp_compare*/
  0,                         /*tp_repr*/
  0,                         /*tp_as_number*/
  0,                         /*tp_as_sequence*/
  0,                         /*tp_as_mapping*/
  0,                         /*tp_hash */
  0,                         /*tp_call*/
  0,                         /*tp_str*/
  0,                         /*tp_getattro*/
  0,                         /*tp_setattro*/
  0,                         /*tp_as_buffer*/
  Py_TPFLAGS_DEFAULT | Py_TPFLAGS_BASETYPE, /*tp_flags*/
  "SPI communication",       /* tp_doc */
  0,                         /* tp_traverse */
  0,                         /* tp_clear */
  0,                         /* tp_richcompare */
  0,                         /* tp_weaklistoffset */
  0,                         /* tp_iter */
  0,                         /* tp_iternext */
  SPI_methods,               /* tp_methods */
  0,                         /* tp_members */
  0,                         /* tp_getset */
  0,                         /* tp_base */
  0,                         /* tp_dict */
  0,                         /* tp_descr_get */
  0,                         /* tp_descr_set */
  0,                         /* tp_dictoffset */
  (initproc)SPI_init,        /* tp_init */
  0,                         /* tp_alloc */
  SPI_new,                   /* tp_new */
};

static PyMethodDef module_methods[] = {
  {NULL}  /* Sentinel */
};

PyMODINIT_FUNC
initRPI_icestick_spi(void)
{
  PyObject* m;

  if( wiringPiSetup() ){
    fprintf(stderr, "Could not initialize the GPIO pins");
    return;
  }

  if( wiringPiSPISetup(SPI_num, 500000) == -1 ){
    fprintf(stderr, "Could not setup spi interface\n");
    return;
  }
    
  if (PyType_Ready(&SPIType) < 0){
    return;
  }

  m = Py_InitModule3("RPI_icestick_spi",
		     module_methods,
		     "Python interface to the icestick40 fpga."
		     );

  if (m == NULL){
    return;
  }

  Py_INCREF(&SPIType);
  PyModule_AddObject(m, "SPI", (PyObject *)&SPIType);
}