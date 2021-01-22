import RPI_icestick_spi as cSPI

class SPI_interface():

    def __init__(self):
        self.SPI = cSPI.SPI()
        self.incoming = []

    def send_byte(self, data):
        received_data = self.SPI.sendrecv_byte(data)

        if( received_data is not None ):
            self.incoming.append(received_data)

    def recv_byte(self):
        if( self.incoming ):
            return self.incoming.pop(0)
        else:
            return None
    
    def send_string(self, data):
        raise( Exception('not yet implemented') )
    
        for c in data:
            received_data = self.SPI.sendrecv_byte(c)
            if( received_data is not None ):
                self.incoming.append(received_data)

    def recv_string(self):
        raise( Exception('not yet implemented') )