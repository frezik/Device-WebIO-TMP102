# Copyright (c) 2014  Timm Murray
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are met:
# 
#     * Redistributions of source code must retain the above copyright notice, 
#       this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright 
#       notice, this list of conditions and the following disclaimer in the 
#       documentation and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.
package Device::WebIO::TMP102;

# ABSTRACT: Implement the TMP102 temperature sensor for Device::WebIO
use v5.14;
use warnings;
use Moo;
use namespace::autoclean;

use constant SLAVE_ADDR    => 0x48;
use constant TEMP_REGISTER => 0x00;


with 'Device::WebIO::Device::TempSensor';
with 'Device::WebIO::Device::I2CUser';

sub BUILDARGS
{
    my ($class, $args) = @_;
    $args->{address} //= $class->SLAVE_ADDR;
    return $args;
}


sub pin_desc
{
    # Placeholder
}

sub all_desc
{
    # Placeholder
}


sub temp_celsius
{
    my ($self) = @_;
    my $webio    = $self->webio;
    my $provider = $self->provider;
    my $channel  = $self->channel;
    my $addr     = $self->address;

    return $webio->i2c_read( $provider,
        $channel, $addr, $self->TEMP_REGISTER, 1 );
}

sub temp_kelvins
{
    my ($self) = @_;
    return $self->_convert_c_to_k( $self->temp_celsius );
}

sub temp_fahrenheit
{
    my ($self) = @_;
    return $self->_convert_c_to_f( $self->temp_celsius );
}


1;
__END__

