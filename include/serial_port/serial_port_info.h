#pragma once
#ifndef SERIAL_PORT_INFO_H
#define SERIAL_PORT_INFO_H

#include <atlbase.h>
#include <iostream>
#include <string>
#include <vector>

#if !defined(SERIAL_PORT_EXPORT)
#define SERIAL_PORT_EXPORT
#endif

namespace SerialPortUtils
{
    /**
     * @brief Serial Port Information
     */
    class SERIAL_PORT_EXPORT SerialPortInfo
    {
    public:
        static std::vector<std::string> toFriendlyNameList(std::vector<SerialPortInfo> serialPorts);
        static std::vector<int> toPortList(std::vector<SerialPortInfo> serialPorts);

    public:
        /**
         * @brief Port. Default as -1.
         */
        int port = -1;

        /**
         * @brief Device Name use for QueryDosDevice()
         */
        LPTSTR queryDosDeviceName = nullptr;

        /**
         * @brief Device Names
         */
        std::string deviceName;

        /**
         * @brief Friendly Name
         */
        std::string friendlyName;

        // To string

        /**
         * @brief To String
         *
         * @return Return string
         */
        operator std::string() const
        {
            return friendlyName;
        }

        friend std::ostream& operator<<(std::ostream& out, const SerialPortInfo& obj)
        {
            return out << (std::string)obj;
        }
    };
} // namespace SerialPortUtils

//*******************************

#endif